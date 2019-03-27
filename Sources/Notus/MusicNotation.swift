import Foundation

public enum Music {
    case prim(Primitive)
    indirect case stack(Music, Music)
    indirect case seq(Music, Music)
    indirect case modify(Control, Music)
}

public enum Control {
    case tempo(Bpm)
    case volume(Vol)
    case transpose(RelativePitch)
    case staff(Staff)
    case player(PlayerName)
    case interpret([PhraseAttribute])
}

public enum PhraseAttribute {
    case tempo(TempoDirection)
    case dynamic(Dynamic)
    case articulation(Articulation)
    case ornament(Ornament)
}

public enum Primitive {
    case note(Dur, Pitch)
    case noteAttr(Dur, Pitch, [NoteAttribute])
    case rest(Dur)
    case none
}

infix operator |=|: MultiplicationPrecedence
infix operator ++: AdditionPrecedence
infix operator =>: AssignmentPrecedence

public extension Music {
    static func ++ (left: Music, right: Music) -> Music {
        return .seq(left, right)
    }
}

public extension Music {
    static func |=| (left: Music, right: Music) -> Music {
        return .stack(left, right)
    }
}

public extension Music {
    static func => (left: Control, right: Music) -> Music {
        return .modify(left, right)
    }
}

extension Primitive: Equatable {
    public static func == (left: Primitive, right: Primitive) -> Bool {
        switch (left, right) {
        case (let .note(leftDur, leftPitch), let .note(rightDur, rightPitch)):
            return leftDur == rightDur && leftPitch == rightPitch
        case (let .rest(leftDur), let .rest(rightDur)):
            return leftDur == rightDur
        case _:
            return false
        }
    }
}

extension Music: Equatable {
    public static func == (lhs: Music, rhs: Music) -> Bool {
        switch (lhs, rhs) {
        case (let .seq(lhsLeft, lhsRight), let .seq(rhsLeft, rhsRight)):
            return lhsLeft == rhsLeft && lhsRight == rhsRight
        case (let .stack(lhsUpper, lhsLower), let .stack(rhsUpper, rhsLower)):
            return lhsUpper == rhsUpper && lhsLower == rhsLower
        case (let .modify(_, leftMusic), let .modify(_, rightMusic)):
            return leftMusic == rightMusic
        case (let .prim(leftPrim), let .prim(rightPrim)):
            return leftPrim == rightPrim
        case _:
            return false
        }
    }
}

/// syntactic sugar
public func O(_ dur: Dur, _ pitch: Pitch, _ attrs: [NoteAttribute]? = nil) -> Music {
    if let attrs = attrs {
        return .prim(.noteAttr(dur, pitch, attrs))
    } else {
        return .prim(.note(dur, pitch))
    }
}

public func R(_ dur: Dur) -> Music {
    return .prim(.rest(dur))
}

