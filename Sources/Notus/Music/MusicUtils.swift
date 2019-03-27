import Foundation

extension Music {
    public func repeated(_ times: UInt8 = 1) -> Music {
        switch times {
        case 0: return self
        case _: return self ++ repeated(times-1)
        }
    }
}

public struct PitchS: Hashable {
    public let pitchClass: PitchClass
    public let octave: Octave
    
    public init(_ pitchClass: PitchClass, _ octave: Octave) {
        self.pitchClass = pitchClass
        self.octave = octave
    }
}

// utilities
public typealias Notes = Set<PitchS>

public func notes(_ items: Pitch...) -> Notes {
    var notes = Notes()
    
    for item in items {
        notes.insert(PitchS(item.0, item.1))
    }
    
    return notes
}

extension Set where Element==PitchS {
    public func stack(_ dur: Dur) -> Music {
        return self.reduce(Music.prim(.none)) { (result, pitch) -> Music in
            return result |=| Music.prim(.note(dur, (pitch.pitchClass, pitch.octave)))
        }
    }
}

public func line(_ listOfMusic: [Music]) -> Music  {
    return listOfMusic.reduce(.prim(.none), { (prev, music) -> Music in
        return .seq(prev, music)
    })
}

public func stacked(_ listOfMusic: [Music]) -> Music  {
    return listOfMusic.reduce(.prim(.none), { (prev, music) -> Music in
        return .stack(prev, music)
    })
}
