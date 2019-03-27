import Foundation

public func lillePeterEdderkop() throws -> (Music, UserPatchMap) {
    
    let upm = try UserPatchMap([(0, .ch0, .acousticGrandPiano)])
    
    let piece = .staff(0) => .tempo(60) => try lillePeterEdderkopNoTempo()
    
    return (piece, upm)
}

public func lillePeterEdderkopTranspose() throws -> (Music, UserPatchMap) {
    let part1 = .staff(0) => .tempo(60) => .transpose(-2) => try lillePeterEdderkopNoTempo()
    let part2 = .staff(1) => .tempo(80) => .transpose(0) => try lillePeterEdderkopNoTempo()
    let part3 = .staff(2) => .tempo(120) => .transpose(5) => try lillePeterEdderkopNoTempo()
    let musicPiece = part1 ++ part2 ++ part3
    
    let upm3 = try UserPatchMap([(0, .ch0, .acousticGrandPiano),
                                (1, .ch1, .stringEnsemble1),
                                (2, .ch3, .hammondOrgan)])
    
    return (musicPiece, upm3)
}

private func lillePeterEdderkopNoTempo() throws -> Music {
    let dMajor: Notes = notes((.d, 4), (.fs, 4), (.a, 4))
    let gMinor: Notes = notes((.d, 4), (.g, 4), (.bf, 4))
    
    let dMajorMelody1: Music =
        O(.en, (.d, 5)) ++ O(.en, (.d, 5)) ++ O(.en, (.d, 5))
            ++ O(.en, (.e, 5))
            ++ O(.en, (.fs, 5)) ++ O(.en, (.fs, 5)) ++ O(.qn, (.fs, 5))
    
    let dMajorMelody2: Music =
        O(.en, (.e, 5)) ++ O(.en, (.d, 5)) ++ O(.en, (.e, 5))
            ++ O(.en, (.fs, 5))
            ++ O(.qn, (.d, 5)) ++ O(.qn, (.d, 5))
    
    let melody = dMajorMelody1 ++ dMajorMelody2
    let harmony = dMajor.stack(.wn) ++ gMinor.stack(.hn) ++ dMajor.stack(.hn)
    
    return melody |=| harmony
}
