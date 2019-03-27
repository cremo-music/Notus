#if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
import Foundation
import Notus

class PlayerManager {
    
    var _player: MidiPlayer!
    
    var soundBankURL: URL? {
        return Bundle.main.url(forResource: "Airfont_340", withExtension: "dls")
    }
    
    func play(song: (Music, UserPatchMap), didFinish: @escaping () -> ()) throws {
        if _player != nil && _player.isPlaying {
            _player.stop()
        }
        
        let (music, upm) = song
        _player = try MidiPlayer(music: music, userPatchMap: upm, soundBankURL: soundBankURL)
        _player.toggleMIDIPlayer(didFinish)
    }
    
    func stop() {
        _player.stop()
    }
}
#endif
