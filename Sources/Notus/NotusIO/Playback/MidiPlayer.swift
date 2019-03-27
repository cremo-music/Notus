//
//  Inspired by: https://github.com/genedelisa/MIDIPlayer
//

#if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
import Foundation
import AVFoundation

public class MidiPlayer {        
    private var midiPlayer: AVMIDIPlayer!

    public var isPlaying: Bool {
        return midiPlayer.isPlaying
    }
    
    public init(music: Music, userPatchMap: UserPatchMap, soundBankURL: URL?) throws {
        let musicSequence = try music.toMusicSequence(playerMap: playerMapDefault, userPatchMap: userPatchMap)
        createMidiPlayerFromMusicSequence(musicSequence, soundBankURL: soundBankURL)
    }
    
    public init(fileURL: URL, soundBankURL: URL?) {
        createMIDIPlayerFromFile(fileURL: fileURL, soundBankURL: soundBankURL)
    }
    
    public func stop() {
        if isPlaying {
            midiPlayer.stop()
        }
    }
    
    public func toggleMIDIPlayer(_ didFinish: @escaping () -> ()) {
        if isPlaying {
            midiPlayer.stop()
            midiPlayer.currentPosition = 0
        } else {
            midiPlayer.play(
                {
                    self.midiPlayer.stop()
                    didFinish()
                }
            )
        }
    }
    
    // from MIDI file
    private func createMIDIPlayerFromFile(fileURL: URL, soundBankURL: URL?) {
        
        do {
            try self.midiPlayer = AVMIDIPlayer(contentsOf: fileURL, soundBankURL: soundBankURL)
            self.midiPlayer.prepareToPlay()
            print("Created MIDI player with sound bank URL: \(String(describing: soundBankURL))")
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    // from MusicSequence
    private func createMidiPlayerFromMusicSequence(_ musicSequence: MusicSequence, soundBankURL: URL?) {
        var status = noErr
        var data: Unmanaged<CFData>?
        status = MusicSequenceFileCreateData(musicSequence, MusicSequenceFileTypeID.midiType, MusicSequenceFileFlags.eraseFile, 480, &data)
        if status != noErr {
            print("Error, bad status: \(status)")
        }
        
        guard let md = data else {
            print("Error: No data")
            return
        }
        
        let midiData = md.takeUnretainedValue() as Data
        do {
            try self.midiPlayer = AVMIDIPlayer(data: midiData, soundBankURL: soundBankURL)
            print("Created MIDI player with sound bank URL: \(String(describing: soundBankURL))")
        } catch let error as NSError {
            print("Error: \(error.localizedDescription)")
        }
        
        data?.release()
    }
}
#endif
