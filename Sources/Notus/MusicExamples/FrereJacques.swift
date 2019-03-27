import Foundation

public func frereJacques() throws -> (Music, UserPatchMap) {
    
    let bassPart: Music = (O(.qn, (.d, 2), [NoteAttribute.volume(48)]) ++
                           O(.qn, (.a, 1), [NoteAttribute.volume(48)])).repeated()
    
    let melOct: Octave = 3
    let melody1: Music = O(.qn, (.d, melOct)) ++ O(.qn, (.e, melOct)) ++
        O(.en, (.f, melOct)) ++ O(.en, (.e, melOct)) ++ O(.qn, (.d, melOct))
    
    let melody2: Music = O(.qn, (.f, melOct)) ++ O(.qn, (.g, melOct)) ++ O(.hn, (.a, melOct))
    
    let melody3: Music = O(.den, (.a, melOct)) ++ O(.sn, (.bf, melOct)) ++
        O(.en, (.a, melOct)) ++ O(.en, (.g, melOct)) ++
        O(.en, (.f, melOct)) ++ O(.en, (.e, melOct)) ++ O(.qn, (.d, melOct))
    
    let melody4: Music = O(.qn, (.a, melOct)) ++ O(.qn, (.a, melOct-1)) ++ O(.hn, (.d, melOct))
    
    let fullMelody = melody1.repeated() ++
                     melody2.repeated() ++
                     melody3.repeated() ++
                     melody4.repeated()
    
    let obOct: Octave = 5
    let oboeMelody1 = .interpret([.articulation(.staccato)]) =>
        O(.en, (.d, obOct)) ++ R(.sn) ++ O(.sn, (.d, obOct)) ++ O(.en, (.d, obOct)) ++
        O(.en, (.f, obOct)) ++ O(.en, (.d, obOct)) ++ R(.en) ++  O(.qn, (.a, obOct-1)) ++
        O(.en, (.d, obOct)) ++ R(.sn) ++ O(.sn, (.d, obOct)) ++ O(.en, (.d, obOct)) ++
        O(.en, (.a, obOct)) ++ O(.hn, (.d, obOct))
    
    let oboeMelody2 = (.interpret([.articulation(.staccato)]) =>
        O(.en, (.a, obOct)) ++ R(.sn) ++ O(.sn, (.bf, obOct)) ++ O(.en, (.a, obOct)) ++
        O(.en, (.a, obOct)) ++ O(.en, (.d, obOct+1)) ++ R(.en) ++  O(.qn, (.a, obOct)) ++
        O(.en, (.d, obOct+1)) ++ R(.en) ++ O(.qn, (.a, obOct)) ++ O(.en, (.g, obOct)) ++
        O(.en, (.f, obOct))) ++ O(.qn, (.e, obOct)) ++ O(.qn, (.d, obOct)) ++ R(.qn) ++ R(.hn)
    
    let oboeMelody = oboeMelody1 ++ oboeMelody2
    
    
    let staff0Part = .staff(0) => bassPart.repeated(31) ++
                                  O(.qn, (.d, 2), [NoteAttribute.volume(48)]) ++
                                  O(.qn, (.a, 1), [NoteAttribute.volume(48)]) ++
                                  O(.hn, (.d, 2), [NoteAttribute.volume(48)])
    let staff1Part = .staff(1) => R(.wn).repeated() ++ fullMelody.repeated(2) ++ O(.wn, (.d, melOct)).repeated(6)
    let staff2Part = .staff(2) => R(.wn).repeated(7) ++ fullMelody.repeated(2) ++ O(.wn, (.a, melOct))
    let staff3Part = .staff(3) => R(.wn).repeated(9) ++ fullMelody.repeated() ++ O(.wn, (.d, melOct)).repeated(5) ++ O(.wn, (.a, melOct))
    let staff7Part = .staff(4) => R(.wn).repeated(17) ++ (.transpose(12) => fullMelody)
    
    let staff4Part = .staff(5) => .transpose(-12) => R(.wn).repeated(13) ++ fullMelody.repeated() ++ O(.wn, (.d, melOct)).repeated(2)
    let staff5Part = .staff(6) => R(.wn).repeated(15) ++ fullMelody.repeated() ++ O(.wn, (.d, melOct))
    let staff6Part = .staff(7) => R(.wn).repeated(17) ++ .modify(.volume(120), oboeMelody)

    let piece = .tempo(60) => staff0Part |=|
                              staff1Part |=|
                              staff2Part |=|
                              staff3Part |=|
                              staff4Part |=|
                              staff5Part |=|
                              staff6Part |=|
                              staff7Part
    
    let upm = try UserPatchMap([(0, .ch0, .timpani),
                                (1, .ch1, .cello),
                                (2, .ch2, .bassoon),
                                (3, .ch3, .stringEnsemble1),
                                (4, .ch4, .stringEnsemble1),
                                (5, .ch5, .tuba),
                                (6, .ch6, .clarinet),
                                (7, .ch7, .oboe)])
    return (piece, upm)
}
