#if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
import Foundation
import AVFoundation

public func importFromMidi(fileUrl: URL) throws -> (Music, UserPatchMap) {
    
    var musicSequence: MusicSequence?
    var status = NewMusicSequence(&musicSequence)
    try validateStatus(status, domain: "MidiToMusic", method: "importFromMidi")
    if let sequence = musicSequence {
        status = MusicSequenceFileLoad(sequence, fileUrl as CFURL, .midiType, MusicSequenceLoadFlags())
        try validateStatus(status, domain: "MidiToMusic", method: "importFromMidi")
    }
    let (music, upm) = try musicSequence!.toMusic()
    return (music, upm)
}

extension MusicSequence {

    typealias TrackIndex = UInt32
    
    /// Creates Music data type from a MusicSequence.
    /// This function converts all events in each track to Music data type,
    /// extracts tempo changes and sets up the correct channels.
    public func toMusic() throws -> (Music, UserPatchMap) {
        let tempos = try tempoFromMusicSequence(self)
        let (eventsPerTrack, instruments) = try musicSequenceToEvents(self)
        let upmChannels = eventsPerTrack.map({ (track: TrackIndex, events: [Event]) -> (Staff, Channel, Instrument) in
            let channel = getChannelOrDefault(events: events)
            let instrument = getInstrumentOrDefault(instruments: instruments[track])
            return (Staff(track), channel, instrument)
        })
        let upm = try UserPatchMap(upmChannels)
        let music: Music = eventsToMusic(eventsPerTrack, tempos: tempos)
        return (music, upm)
    }

    public func writeMidiFile(fileUrl: URL) throws {
        let inFileRef = CFBridgingRetain(fileUrl) as! CFURL
        
        MusicSequenceFileCreate(self,
                                inFileRef,
                                MusicSequenceFileTypeID.midiType,
                                MusicSequenceFileFlags.eraseFile,
                                0)
    }
    
    private func getChannelOrDefault(events: [Event]) -> Channel {
        // first event determines the channel
        if let event = events.first {
            return event.ch
        } else {
            return Channel.ch0
        }
    }
    
    private func getInstrumentOrDefault(instruments: [Instrument]?) -> Instrument {
        // first instrument change (if any) determines instrument
        if let instrument = instruments?.first {
            return instrument
        } else {
            return Instrument.acousticGrandPiano
        }
    }
    
    
    private func musicSequenceToEvents(_ musicSequence: MusicSequence) throws ->
        ([TrackIndex: [Event]], [TrackIndex: [Instrument]]) {
            var trackCount: UInt32 = 0
            var status = MusicSequenceGetTrackCount(musicSequence, &trackCount)
            try validateStatus(status, domain: "MidiToMusic", method: "musicSequenceToEvents")
            
            var events: [TrackIndex: [Event]] = [:]
            var instruments: [TrackIndex: [Instrument]] = [:]
            
            for trackIndex in 0...trackCount-1 {
                var currentTrack: MusicTrack!
                status = MusicSequenceGetIndTrack(musicSequence, trackIndex, &currentTrack)
                try validateStatus(status, domain: "MidiToMusic", method: "musicSequenceToEvents")
                
                let eventsForTrack: [Event] = try parseEventsForTrack(track: currentTrack)
                let instrumentsForTrack: [Instrument] = try parseInstrumentsForTrack(track: currentTrack)
                if eventsForTrack.isEmpty {
                   continue
                }
                events[trackIndex] = eventsForTrack
                instruments[trackIndex] = instrumentsForTrack
            }
            
            return (events, instruments)
    }
    
    private func tempoFromMusicSequence(_ musicSequence: MusicSequence) throws -> [(MusicTimeStamp, Bpm)] {
        var tempoTrack: MusicTrack?
        let status = MusicSequenceGetTempoTrack(musicSequence, &tempoTrack)
        try validateStatus(status, domain: "MidiToMusic", method: "musicSequenceToEvents")
        
        var midiMapper = MidiTempoEventsToNotusBuilder()
        try scanEvents(track: tempoTrack!, midiMapper: &midiMapper)        
        return midiMapper.tempoEvents.compactMap { $0 }
    }
    
    private func scanEvents<T>(track: MusicTrack, midiMapper: inout T) throws where T : MidiToNotusBuilderProtocol {
        
        var eventIterator: MusicEventIterator?
        var hasCurrent: DarwinBoolean = false
        var timestamp: MusicTimeStamp = 0
        var eventType: MusicEventType = 0
        var eventData: UnsafeRawPointer? = nil
        var eventDataSize: UInt32 = 0
        
        var status = NewMusicEventIterator(track, &eventIterator)
        try validateStatus(status, domain: "MidiToMusic", method: "scanEvents")
        
        status = MusicEventIteratorHasCurrentEvent(eventIterator!, &hasCurrent)
        try validateStatus(status, domain: "MidiToMusic", method: "scanEvents")
        
        while (hasCurrent.boolValue) {
            status = MusicEventIteratorGetEventInfo(eventIterator!,
                                                    &timestamp,
                                                    &eventType,
                                                    &eventData,
                                                    &eventDataSize)

            try validateStatus(status, domain: "MidiToMusic", method: "scanEvents")
            
            midiMapper.eventData = eventData
            midiMapper.parse(eventType: eventType, timestamp: timestamp)
        
            status = MusicEventIteratorNextEvent(eventIterator!)
            try validateStatus(status, domain: "MidiToMusic", method: "scanEvents")
            
            status = MusicEventIteratorHasCurrentEvent(eventIterator!, &hasCurrent)
            try validateStatus(status, domain: "MidiToMusic", method: "scanEvents")
        }
    }
    
    private func parseInstrumentsForTrack(track: MusicTrack) throws -> [Instrument] {
        var midiMapper = MidiInstrumentsToNotusBuilder()
        try scanEvents(track: track, midiMapper: &midiMapper)
        return midiMapper.instruments
    }
    
    private func parseEventsForTrack(track: MusicTrack) throws -> [Event] {
        var midiMapper = MidiEventsToNotusBuilder()
        try scanEvents(track: track, midiMapper: &midiMapper)
        return midiMapper.events
    }
    
    private func eventsToMusic(_ events: [TrackIndex : [Event]],
                                      tempos: [(MusicTimeStamp, Bpm)]) -> Music {
        let listOfMusic = events.map({(trackIndex: TrackIndex, trackEvents: [Event]) -> Music in
            return .staff(Staff(trackIndex)) => trackEventsToMusic(trackEvents, trackIndex, tempos)
        })
        return stacked(listOfMusic)
    }
    
    /// Function to replace zero duration notes with notes that last until the next note is played.
    /// TODO: This function is not currently used because it introduced other errors.
    private func replaceZeroDurations(events: [Event]) -> [Event] {
        let timestamps = Array(events.map({$0.time}).dropFirst())
        let eventsExceptLast = events.dropLast()
        let timestampsAndEvents = Array(zip(timestamps, eventsExceptLast))
        
        let zeroesReplaced = timestampsAndEvents.map({ (nextEventTime: MusicTimeStamp, currentEvent: Event) -> Event in
            if currentEvent.dur < 1e-6 {
                let newDur: DurT = DurT(nextEventTime - currentEvent.time)
                return Event(pitch: currentEvent.pitch,
                             ch: currentEvent.ch,
                             instr: currentEvent.instr,
                             vol: currentEvent.vol,
                             time: currentEvent.time,
                             dur: newDur)
            } else {
                return currentEvent
            }
        })
        return zeroesReplaced
    }
    
    private func trackEventsToMusic(_ trackEvents: [Event],
                                    _ trackIndex: TrackIndex,
                                    _ tempos: [(MusicTimeStamp, Bpm)]) -> Music {
        // TODO: Maybe replace zero duration notes with notes lasting until the next duration
        let allMusicAndTime = trackEvents.map({ (Music.fromEvent($0), $0.time)}).sorted {$0.1 < $1.1}
        let tempoBegins = tempos.map { $0.0 }
        let maybeLastTimestamp = (trackEvents.map { MusicTimeStamp($0.time + Time($0.dur)) }).max()
        if let lastTimestamp = maybeLastTimestamp {
            var tempoEnds = Array(tempoBegins.dropFirst())
            tempoEnds.append(lastTimestamp)
            let tempoTimestamps = Array(zip(tempoBegins, tempoEnds))
            let musicSplit = splitByTimestamps(allMusicAndTime, timestamps: tempoTimestamps)
            let musicAndTempo = zip(musicSplit, tempos.map { $0.1 })
            let musicWithTempoChanges = musicAndTempo.map { .tempo($0.1) => compileMusic(musicAndTime: $0.0) }
            return line(musicWithTempoChanges)
        } else {
            return compileMusic(musicAndTime: allMusicAndTime)
        }
        
    }
    
    private func compileMusic(musicAndTime: [(Music, MusicTimeStamp)]) -> Music {
        var melodiesAcc = [[Music]]()
        let melodies: [[Music]] = extractAllMonophonicMelodies(musicAndTime: musicAndTime, melodiesAcc: &melodiesAcc)
        let music = stacked(melodies.map { line($0) })
        
        return music
    }
    
    private func extractAllMonophonicMelodies(musicAndTime: [(Music, MusicTimeStamp)],
                                              melodiesAcc: inout [[Music]]) -> [[Music]] {
        
        if let head = musicAndTime.first {
            var tail = musicAndTime
            tail.removeFirst()
            
            var melodyAcc: [Music] = []
            if head.1 > 0 {
                let restDurs = Dur.toNotusDurations(DurT(head.1))
                let rest = line(restDurs.map({R($0)}))
                melodyAcc.append(rest)
            }
            
            melodyAcc.append(head.0)
            
            let (oneMelody, remainingMusic) = extractOneMonophonicMelody(head: head, tail: tail, melodyAcc: &melodyAcc)
            melodiesAcc.append(oneMelody)
            return extractAllMonophonicMelodies(musicAndTime: remainingMusic,
                                                melodiesAcc: &melodiesAcc)
        } else {
            return melodiesAcc
        }
        
    }
    
    
    private func extractOneMonophonicMelody(head: (Music, MusicTimeStamp),
                                                   tail: [(Music, MusicTimeStamp)],
                                                   melodyAcc: inout [Music]) -> ([Music], [(Music, MusicTimeStamp)]) {

        let nextTimestamp = head.1 + MusicTimeStamp(head.0.duration())
        
        if tail.isEmpty {
            return (melodyAcc, [])
        } else {
            if let indexOfNextMelodyNote = tail.firstIndex(where: { $0.1 >= nextTimestamp}) {
                let nextMelodyNote = tail[indexOfNextMelodyNote]
                let prevEndTimestamp = head.1 + MusicTimeStamp(head.0.duration())
                let restDur = nextMelodyNote.1 - prevEndTimestamp
                if restDur > 0 {
                    let restDurs = Dur.toNotusDurations(DurT(restDur))
                    let rest = line(restDurs.map({R($0)}))
                    melodyAcc.append(rest)
                }
                
                var newTail = tail
                newTail.remove(at: indexOfNextMelodyNote)
                melodyAcc.append(nextMelodyNote.0)
                
                return extractOneMonophonicMelody(head: nextMelodyNote,
                                                  tail: newTail,
                                                  melodyAcc: &melodyAcc)
            } else {
                return (melodyAcc, tail)
            }
        }
    }
    

    private func splitByTimestamps(_ musicAndTime: [(Music, MusicTimeStamp)],
                                          timestamps: [(MusicTimeStamp, MusicTimeStamp)]) -> [[(Music, MusicTimeStamp)]] {
        let musicSplit = timestamps.map( { (timeBegin, timeEnd) -> [(Music, MusicTimeStamp)] in
            return musicAndTime.filter { $0.1 >= timeBegin && $0.1 < timeEnd}
        })
        return musicSplit
    }
}
#endif
