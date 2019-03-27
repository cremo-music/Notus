#if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
import Foundation
import AVFoundation

// To Music Sequence extensions
extension Music {
    public func toMidiFile(userPatchMap: UserPatchMap, fileUrl: URL) throws {
        let sequence = try self.toMusicSequence(playerMap: playerMapDefault, userPatchMap: userPatchMap)
        try sequence.writeMidiFile(fileUrl: fileUrl)
    }

    public func toMusicSequence(playerMap: PlayerMap) throws -> MusicSequence {
        return try toMusicSequence(playerMap: playerMap, userPatchMap: UserPatchMap.makeGMMap(music: self))
    }
    
    public func toMusicSequence(playerMap: PlayerMap, userPatchMap: UserPatchMap) throws -> MusicSequence {
        let seqBuilder = try MusicSequenceBuilder(userPatchMap: userPatchMap)
        
        let performance = perform(playerMap: playerMap, userPatchMap: userPatchMap)
        
        for event in performance.0 {
            try seqBuilder.setNote(note: event.pitch, atBeat: event.time, withDuration: event.dur,
                                   channel: event.ch, velocity: event.vol, releaseVelocity: 0)
        }
        
        for context in performance.1 {
            try seqBuilder.setTempo(context.tempo, atBeat: context.time)
        }
        
        //CAShow(UnsafeMutablePointer<MusicSequence>(seqBuilder.musicSequence))
        return seqBuilder.musicSequence
    }
}
#endif
