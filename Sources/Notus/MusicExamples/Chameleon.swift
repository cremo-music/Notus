import Foundation

public func chameleon() throws -> (Music, UserPatchMap) {
    
    // bass
    let bassUpbeat: Music = R(.hn) ++ R(.en) ++
        O(.en, (.g, 1)) ++
        O(.en, (.af, 1)) ++
        O(.en, (.a, 1))
    let bassPart1: Music = O(.sn, (.bf, 1)) ++ R(.en) ++
        O(.sn, (.af, 2)) ++ R(.en) ++
        O(.sn, (.bf, 2)) ++ R(.den) ++
        O(.en, (.c, 2)) ++ O(.en, (.df, 2)) ++ O(.en, (.d, 2))
    
    let bassPart2: Music = O(.sn, (.ef, 2)) ++ R(.en) ++
        O(.sn, (.bf, 2)) ++ R(.en) ++
        O(.sn, (.df, 3)) ++ R(.den) ++
        O(.en, (.g, 1)) ++ O(.en, (.af, 1)) ++ O(.en, (.a, 1))
    
    // drums
    let hihat: Music = (O(.en, closedHihat, [NoteAttribute.volume(70)]) ++
                        O(.en, closedHihat, [NoteAttribute.volume(32)]) ++
                        O(.en, closedHihat, [NoteAttribute.volume(70)]) ++
                        O(.en, closedHihat, [NoteAttribute.volume(32)])).repeated()
    let bassDrum: Music = O(.hn, bassDrum1) ++ R(.sn) ++
        O(.sn, bassDrum1) ++ O(.sn, bassDrum1) ++ R(.qn)
    let snareDrum: Music = R(.den) ++ O(.qn, snareDrum1) ++ R(.sn) ++
        R(.qn) ++ O(.qn, snareDrum1)
    let drumsPart: Music = hihat |=| snareDrum |=| bassDrum
    
    // sax
    let saxPart1: Music =        
        O(.sn, (.bf, 3)) ++ O(.sn, (.bf, 3)) ++ R(.en) ++
        O(.sn, (.af, 3)) ++ O(.sn, (.af, 3)) ++ R(.en) ++
        O(.sn, (.bf, 3)) ++ O(.sn, (.bf, 3)) ++ R(.en) ++
        O(.qn, (.df, 4)) ++ O(.en, (.bf, 3)) ++
        R(.en) ++ R(.qn) ++ R(.qn)
    
    let saxPart2: Music = O(.sn, (.bf, 3)) ++ O(.sn, (.af, 3)) ++ O(.sn, (.f, 3)) ++
        O(.den, (.af, 3)) ++ O(.en, (.bf, 3)) ++
        R(.qn) ++ R(.qn) ++ R(.en) ++
        O(.qn, (.df, 4)) ++ O(.en, (.ef, 4)) ++
        R(.qn) ++ R(.hn)
    
    let saxPart = saxPart1 ++ saxPart2
    
    let staff0Part = .staff(0) => bassUpbeat ++ (bassPart1 ++ bassPart2).repeated(7)
    let staff1Part = .staff(1) => R(.wn).repeated(4) ++ drumsPart.repeated(11)
    let staff2Part = .staff(2) => R(.wn).repeated(8) ++ saxPart.repeated(1)
    let staff3Part = .staff(3) => .transpose(12) => R(.wn).repeated(8) ++ saxPart.repeated(1)
    
    
    let piece = .tempo(100) => staff0Part |=| staff1Part |=| staff2Part |=| staff3Part
    
    let upm = try UserPatchMap([(0, .ch0, .bassLead),
                                (1, .ch9, .percussion),
                                (2, .ch1, .baritoneSax),
                                (3, .ch2, .tenorSax)])
    
    return (piece, upm)
}


public func chameleonBass() throws -> (Music, UserPatchMap) {
    
    // bass
    let bassUpbeat: Music = R(.hn) ++ R(.en) ++
        O(.en, (.g, 1)) ++
        O(.en, (.af, 1)) ++
        O(.en, (.a, 1))
    let bassPart1: Music = O(.sn, (.bf, 1)) ++ R(.en) ++
        O(.sn, (.af, 2)) ++ R(.en) ++
        O(.sn, (.bf, 2)) ++ R(.den) ++
        O(.en, (.c, 2)) ++ O(.en, (.df, 2)) ++ O(.en, (.d, 2))
    
    let staff0Part = .staff(0) => bassUpbeat ++ bassPart1
    
    
    let piece = .tempo(100) => staff0Part
    
    let upm = try UserPatchMap([(0, .ch0, .bassLead)])
    
    return (piece, upm)
}
