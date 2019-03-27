import Foundation

public func counterpoint() throws -> (Music, UserPatchMap) {
    
    let melOct: Octave = 4
    let cantusFirmus = O(.qn, (.c, melOct)) ++ O(.qn, (.d, melOct)) ++ O(.qn, (.e, melOct)) ++ O(.qn, (.g, melOct)) ++
                       O(.qn, (.f, melOct)) ++ O(.qn, (.e, melOct)) ++ O(.qn, (.d, melOct)) ++ O(.qn, (.b, melOct-1)) ++ O(.wn, (.c, melOct))
    
    let counterPoint1: Music = O(.en, (.c, melOct + 1)) ++ O(.en, (.b, melOct)) ++
                               O(.en, (.c, melOct + 1)) ++ O(.en, (.a, melOct)) ++
                               O(.en, (.b, melOct)) ++ O(.en, (.g, melOct)) ++
                               O(.en, (.a, melOct)) ++ O(.en, (.f, melOct))
    
    let counterPoint = .transpose(12) => counterPoint1.repeated(1) ++ O(.wn, (.c, melOct + 1))
    
    let piece = .staff(0) => .tempo(100) => cantusFirmus |=| counterPoint
    
    let upm = try UserPatchMap([(0, .ch0, .acousticGrandPiano)])
    
    return (piece, upm)
}
