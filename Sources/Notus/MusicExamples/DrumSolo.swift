import Foundation


public func drumsolo() throws -> (Music, UserPatchMap) {
    
    // drums
    let hihat: Music = (O(.en, closedHihat, [NoteAttribute.volume(64)]) ++
                        O(.en, closedHihat, [NoteAttribute.volume(32)])).repeated(2) ++
                        O(.en, closedHihat, [NoteAttribute.volume(64)]) ++
                        O(.en, openHihat)
    let bassDrum: Music = O(.dqn, bassDrum1) ++ O(.qn, bassDrum1) ++ O(.qn, bassDrum1) ++ R(.en)
    let snareDrum: Music = R(.qn) ++ O(.qn, snareDrum1) ++ R(.qn) ++ O(.qn, snareDrum1)
    let drumsPart: Music = hihat |=| snareDrum |=| bassDrum
    let endPart: Music = O(.sn, snareDrum1).repeated(3) ++ O(.ten, highTom).repeated(2) ++
                         O(.ten, hiMidTom).repeated(2) ++ O(.ten, lowFloorTom).repeated(2) ++
                         (O(.wn, bassDrum1) |=| O(.wn, crashCymbal1))
    
    
    let piece = .staff(0) => drumsPart.repeated(5) ++ endPart
    
    let upm = try UserPatchMap([(0, .ch9, .percussion)])
    
    return (piece, upm)
}
