#if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
import AVFoundation

public struct MusicSequenceBuilder {
    
    let musicSequence: MusicSequence
    private let _tempoTrack: MusicTrack
    private var _tracks: [Channel: MusicTrack] = [Channel: MusicTrack]()
    
    init(userPatchMap: UserPatchMap) throws {
        musicSequence = try MusicSequenceBuilder.createMusicSequence()
        
        _tempoTrack = try MusicSequenceBuilder.createTempoTrack(sequence: musicSequence)
        
        for (_, channel, instrument) in userPatchMap {
            
            let track = try MusicSequenceBuilder.createTrack(sequence: musicSequence)
            _tracks[channel] = track
            
            try MusicSequenceBuilder.setMSB(track: track, channel: channel, data1: UInt8(kAUSampler_DefaultMelodicBankMSB))
            try MusicSequenceBuilder.setLSB(track: track, channel: channel, data1: UInt8(kAUSampler_DefaultBankLSB))
            try MusicSequenceBuilder.setInstrument(instrument, forTrack: track, channel: channel)
        }
    }
    
    func setTempo(_ bpm: UInt, atBeat beat: MusicTimeStamp) throws {
        try validateStatus(MusicTrackNewExtendedTempoEvent(_tempoTrack, beat, Float64(bpm)),
                           domain: "SequenceBuilder", method: "MusicTrackNewExtendedTempoEvent")
    }
    
    func setNote(note: UInt8, atBeat beat: MusicTimeStamp, withDuration dur: Float64,
                 channel: Channel, velocity: UInt8, releaseVelocity: UInt8) throws {
        
        let musicTrack = try track(channel: channel)
        var mess = MIDINoteMessage(channel: channel.rawValue,
                                   note: note,
                                   velocity: velocity,
                                   releaseVelocity: releaseVelocity,
                                   duration: Float32(dur))
        try validateStatus(MusicTrackNewMIDINoteEvent(musicTrack, beat, &mess),
                           domain: "SequenceBuilder", method: "MIDINoteMessage")
    }
    
    func setInstrument(_ midiInstrument: Instrument, channel: Channel) throws {
        let musicTrack = try track(channel: channel)
        
        try MusicSequenceBuilder.setInstrument(midiInstrument, forTrack: musicTrack, channel: channel)
    }
    
    private static func setInstrument(_ midiInstrument: Instrument, forTrack track: MusicTrack, channel: Channel) throws {
        // Program change, first data byte is the patch, the second data byte is unused for program change messages (?)
        // Control/mode change is 0xCn, where n is channel number (0xB = 12*16^1 = 196)
        
        try MusicSequenceBuilder.setMSB(track: track, channel: channel, data1: 0)
        try MusicSequenceBuilder.setLSB(track: track, channel: channel, data1: 32)
        
        let status = 0xC0 + channel.rawValue
        let instrument = (midiInstrument.rawValue - 1) % 128
        var chanmess = MIDIChannelMessage(status: status, data1: instrument, data2: 0, reserved: 0)
        try validateStatus(MusicTrackNewMIDIChannelEvent(track, 0, &chanmess),
                           domain: "SequenceBuilder", method: "MusicTrackNewMIDIChannelEvent")
    }
    
    private func track(channel: Channel) throws -> MusicTrack {
        guard let track = _tracks[channel] else {
            throw NSError(domain: "MusicSequenceBuilder",
                          code: -1,
                          userInfo: [NSLocalizedDescriptionKey: "Track with track number \"\(channel)\" does not exist"])
        }
        
        return track
    }
    
    // bank select msb(?)
    private static func setMSB(track: MusicTrack, channel: Channel, data1: UInt8) throws {
        // Control/mode change is 0xBn, where n is channel number (0xB = 11*16^1 = 176)
        let status = 0xB0 + channel.rawValue
        
        var chanmess = MIDIChannelMessage(status: status, data1: data1, data2:0, reserved: 0)
        try validateStatus(MusicTrackNewMIDIChannelEvent(track, 0, &chanmess),
                           domain: "SequenceBuilder", method: "MusicTrackNewMIDIChannelEvent")
    }
    
    // bank select lsb(?)
    private static func setLSB(track: MusicTrack, channel: Channel, data1: UInt8) throws {
        // Control/mode change is 0xBn, where n is channel number (0xB = 11*16^1 = 176)
        let status = 0xB0 + channel.rawValue
        
        var chanmess = MIDIChannelMessage(status: status, data1: data1, data2: 0, reserved: 0)
        try validateStatus(MusicTrackNewMIDIChannelEvent(track, 0, &chanmess),
                           domain: "SequenceBuilder", method: "MusicTrackNewMIDIChannelEvent")
        
    }
    
    private static func createMusicSequence() throws -> MusicSequence {
        var musicSequence: MusicSequence?
        try validateStatus(NewMusicSequence(&musicSequence),
                           domain: "SequenceBuilder", method: "NewMusicSequence")
        
        return musicSequence!
    }
    
    private static func createTempoTrack(sequence: MusicSequence) throws -> MusicTrack {
        var tempoTrack: MusicTrack?
        try validateStatus(MusicSequenceGetTempoTrack(sequence, &tempoTrack),
                           domain: "SequenceBuilder", method: "MusicSequenceGetTempoTrack")
        
        return tempoTrack!
    }
    
    private static func createTrack(sequence: MusicSequence) throws -> MusicTrack {
        var track: MusicTrack?
        try validateStatus(MusicSequenceNewTrack(sequence, &track),
                           domain: "SequenceBuilder", method: "MusicSequenceNewTrack")
        
        return track!
    }
}
#endif
