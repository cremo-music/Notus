#if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
import Foundation
import AVFoundation

protocol MidiToNotusBuilderProtocol {
    var eventData: UnsafeRawPointer? { get set}
    mutating func parse(eventType: MusicEventType, timestamp: MusicTimeStamp)
}

struct MidiInstrumentsToNotusBuilder: MidiToNotusBuilderProtocol {
    
    var eventData: UnsafeRawPointer?
    
    let eventType = kMusicEventType_MIDIChannelMessage    
    var instruments = [Instrument]()
    
    mutating func parse(eventType: MusicEventType, timestamp: MusicTimeStamp) {
        if (self.eventType != eventType) {
            return
        }
        
        guard let midiEvent = eventData?.bindMemory(to: MIDIChannelMessage.self, capacity: 1).pointee else {
            return
        }
        
        let status: UInt8? = midiEvent.status
        let data1: UInt8? = midiEvent.data1
        
        if let statusInt = status {
            if (statusInt >= 0xC0 && statusInt < 0xCF) {
                // Program Change
                instruments.append(instrumentFromRawValue(data1! + 1)!)
            }
        }
    }
}

struct MidiEventsToNotusBuilder: MidiToNotusBuilderProtocol {
    
    let eventType = kMusicEventType_MIDINoteMessage
    var eventData: UnsafeRawPointer?
    var events = [Event]()
    
    mutating func parse(eventType: MusicEventType, timestamp: MusicTimeStamp) {
        if (self.eventType != eventType) {
            return
        }
        
        guard let midiEvent = eventData?.bindMemory(to: MIDINoteMessage.self, capacity: 1).pointee else {
            return
        }
        
        let note = midiEvent.note
        let dur = midiEvent.duration
        let ch = midiEvent.channel
        let vol = midiEvent.velocity
        
        events.append(Event(pitch: note,
                            ch: channelFromRawValue(ch)!,
                            instr: Instrument.acousticGrandPiano,
                            vol: vol,
                            time: timestamp,
                            dur: Float64(dur)))
    }
}

struct MidiTempoEventsToNotusBuilder: MidiToNotusBuilderProtocol {
    
    let eventType = kMusicEventType_ExtendedTempo
    var eventData: UnsafeRawPointer?
    var tempoEvents = [(MusicTimeStamp, Bpm)]()
    
    mutating func parse(eventType: MusicEventType, timestamp: MusicTimeStamp) {
        if (self.eventType != eventType) {
            return
        }
        
        guard let midiEvent = eventData?.bindMemory(to: ExtendedTempoEvent.self, capacity: 1).pointee else {
            return
        }
        
        let tempo: Bpm = Bpm(midiEvent.bpm)
        tempoEvents.append((timestamp, tempo))
    }
}
#endif
