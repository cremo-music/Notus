import Foundation

public func triol() throws -> (Music, UserPatchMap) {
    
    let melOct: Octave = 5
    let triol = O(.tqn, (.c, melOct)) ++ O(.tqn, (.e, melOct)) ++ O(.tqn, (.b, melOct - 1))
    let dotted = O(.den, (.c, melOct)) ++ O(.den, (.e, melOct)) ++ O(.den, (.b, melOct - 1))
    let sixteen = O(.sn, (.c, melOct)) ++ O(.sn, (.e, melOct)) ++ O(.sn, (.g, melOct)) ++ O(.sn, (.e, melOct))
    let ten = O(.ten, (.c, melOct)) ++ O(.ten, (.e, melOct)) ++ O(.ten, (.b, melOct - 1))
    
    let piece = triol.repeated(3) ++ dotted.repeated(3) ++ sixteen.repeated(2) ++ ten.repeated(3)
    
    let upm = try UserPatchMap([(0, .ch0, .acousticGrandPiano)])
    
    return (piece, upm)
}
