import Foundation

public func james() throws -> (Music, UserPatchMap) {
    
    // chords
    let co: Octave = 3
    let chord1: Music = O(.hn, (.c, co))  |=| (R(.qn) ++ O(.qn, (.f, co)) |=| O(.qn, (.af, co)) |=| O(.qn, (.c, co+1 )))
    let chord2: Music = O(.hn, (.df, co)) |=| (R(.qn) ++ O(.qn, (.f, co)) |=| O(.qn, (.af, co)) |=| O(.qn, (.df, co+1)))
    let chord3: Music = O(.hn, (.d, co))  |=| (R(.qn) ++ O(.qn, (.f, co)) |=| O(.qn, (.af, co)) |=| O(.qn, (.d, co+1)))
    
    // melody
    let mo: Octave = 3
    let melody1: Music = O(.en, (.f, mo)) ++ O(.sn, (.g, mo)).repeated() ++ O(.en, (.g, mo)) ++ O(.qn, (.g, mo))  ++
                         O(.en, (.f, mo)).repeated(2)
    let melody2: Music = O(.en, (.f, mo)) ++ O(.sn, (.af, mo)).repeated() ++ O(.en, (.af, mo)) ++ O(.qn, (.af, mo))  ++
                         O(.en, (.g, mo)).repeated(2)
    let melody3: Music = O(.en, (.f, mo)) ++ O(.sn, (.af, mo)).repeated() ++ O(.en, (.af, mo)) ++ O(.qn, (.af, mo))  ++
                         O(.en, (.g, mo)) ++ O(.en, (.gf, mo)) ++ O(.en, (.f, mo))
    let melody4: Music = O(.en, (.e, mo+1)) ++ O(.hn, (.ef, mo+1)) ++ R(.en) ++
                         O(.en, (.c, mo+1)) ++ O(.en, (.bf, mo))
    let melody5: Music = O(.wn, (.c, mo+1))
    
    // drums
    let hihat: Music = (R(.qn) ++ O(.qn, pedalHihat)).repeated()
    let cymbal: Music = (O(.en, rideCymbal1, [NoteAttribute.volume(64)]) ++
                         O(.sn, rideCymbal1, [NoteAttribute.volume(32)]) ++ O(.sn, rideCymbal1, [NoteAttribute.volume(32)]) ++
                         O(.en, rideCymbal1, [NoteAttribute.volume(64)]) ++
                         O(.sn, rideCymbal1, [NoteAttribute.volume(32)]) ++ O(.sn, rideCymbal1, [NoteAttribute.volume(32)])).repeated()
    
    let chords = .staff(0) => (chord1 ++ chord2 ++ chord3 ++ chord2)
    let melody = .staff(1) => (melody1 ++ melody2).repeated() ++ (melody1 ++ melody3 ++ melody4 ++ melody5)
    let drums: Music = .staff(2) => (hihat |=| cymbal).repeated()
    
    let piece = .tempo(130) => (chords |=| drums).repeated() ++ (melody |=| chords.repeated(3) |=| drums.repeated(3)).repeated()
    
    let upm = try UserPatchMap([(0, .ch0, .electricMutedGuitar),
                                (1, .ch1, .electricCleanGuitar),
                                (2, .ch9, .percussion)])
    
    return (piece, upm)
}
