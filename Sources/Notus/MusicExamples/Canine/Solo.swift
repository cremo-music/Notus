import Foundation

//
// Solo
//

private let phrase2: Music = O(.en, (.ds, 6)) ++ O(.sn, (.b, 5)) ++ O(.sn, (.gs, 5)) ++
    O(.sn, (.a, 5)) ++ O(.sn, (.b, 5)) ++ O(.sn, (.cs, 6)) ++ O(.sn, (.a, 5)) ++
    O(.en, (.b, 5)) ++ O(.en, (.a, 5)) ++ O(.qn, (.fs, 5))

private let phrase3: Music = R(.en) ++ O(.sn, (.d, 6)) ++ O(.sn, (.gf, 5)) ++
    O(.tsn, (.b, 5)) ++ O(.tsn, (.a, 5)) ++ O(.tsn, (.fs, 5)) ++ O(.sn, (.e, 5)) ++ O(.sn, (.fs, 5)) ++
    O(.sn, (.b, 5)) ++ O(.sn, (.fs, 5)) ++ O(.sn, (.b, 5)) ++ O(.sn, (.fs, 5)) ++ //todo bend
    O(.sn, (.fs, 5)) ++ O(.sn, (.gs, 5)) ++ O(.sn, (.a, 5)) ++ O(.sn, (.b, 5)) ++
    O(.en, (.c, 6)) ++ O(.sn, (.gs, 5)) ++ O(.sn, (.b, 5)) ++
    R(.sn) ++ O(.sn, (.a, 5)) ++ R(.en) ++
    O(.sn, (.fs, 5)) ++ O(.sn, (.gs, 5)) ++ O(.sn, (.b, 5)) ++ O(.sn, (.gs, 5)) ++
    R(.sn) ++ O(.sn, (.fs, 5)) ++ O(.sn, (.e, 5)) ++ O(.sn, (.d, 5)) ++
    O(.en, (.e, 5)) ++ O(.sn, (.d, 5)) ++ O(.sn, (.fs, 5))

private let phrase4: Music = R(.tsn) ++ R(.tsn) ++
    O(.tsn, (.a, 4)) ++ O(.tsn, (.b, 4)) ++ O(.tsn, (.d, 5)) ++ O(.tsn, (.f, 5)) ++
    O(.tsn, (.a, 5)) ++ R(.tsn) ++ O(.tsn, (.e, 5)) ++ O(.tsn, (.f, 5)) ++ O(.tsn, (.a, 5)) ++ O(.tsn, (.b, 5)) ++
    O(.ten, (.e, 6)) ++ O(.ten, (.d, 6)) ++ O(.ten, (.ds, 6))

private let phrase5: Music = R(.qn) ++ O(.en, (.fs, 5)) ++ O(.en, (.fs, 5)) ++
    O(.sn, (.fs, 5)) ++ O(.sn, (.gs, 5)) ++ R(.en) ++ R(.en) ++ R(.sn) ++ O(.sn, (.b, 5)) ++
    R(.sn) ++ O(.sn, (.b, 5)) ++ R(.en) ++ O(.en, (.b, 5)) ++ O(.sn, (.bf, 5)) ++ O(.sn, (.a, 5)) ++
    R(.qn) ++ R(.qn)

private let phrase6: Music = R(.sn) ++ O(.sn, (.gs, 5)) ++ O(.sn, (.ds, 6)) ++ R(.sn) ++
    O(.sn, (.d, 6)) ++ O(.sn, (.cs, 6)) ++ O(.sn, (.b, 5)) ++ O(.sn, (.gs, 5)) ++
    O(.sn, (.aas, 5)) ++ O(.sn, (.ds, 6)) ++ O(.sn, (.cs, 6)) ++ O(.sn, (.a, 5)) ++
    O(.en, (.g, 5)) ++ O(.en, (.f, 5)) ++
    
    O(.sn, (.e, 5)) ++ O(.sn, (.g, 5)) ++ O(.en, (.d, 5)) ++
    O(.sn, (.c, 5)) ++ O(.sn, (.d, 5)) ++ O(.sn, (.e, 5)) ++ O(.sn, (.g, 5)) ++
    O(.en, (.aas, 5)) ++ O(.tn, (.aas, 5)) ++ O(.tn, (.a, 5)) ++ O(.tn, (.gs, 5)) ++ O(.tn, (.g, 5)) ++
    O(.sn, (.e, 5)) ++ O(.sn, (.g, 5)) ++ O(.sn, (.e, 5)) ++ O(.sn, (.g, 5))

private let phrase7 = O(.sn, (.fs, 5)) ++ O(.sn, (.ds, 5)) ++ O(.en, (.b, 4)) ++
    O(.sn, (.a, 4)) ++ O(.sn, (.b, 4)) ++ O(.sn, (.cs, 5)) ++ O(.sn, (.a, 4)) ++
    O(.en, (.b, 4)) ++ O(.sn, (.a, 4)) ++ O(.sn, (.fs, 4)) ++
    R(.sn) ++ O(.sn, (.a, 4)) ++ R(.sn) ++ O(.sn, (.b, 4)) ++
    R(.sn) ++ O(.sn, (.d, 4)) ++ R(.sn) ++ O(.sn, (.ds, 4)) ++
    R(.sn) ++ O(.sn, (.fs, 4)) ++ O(.sn, (.a, 4)) ++ O(.sn, (.c, 5)) ++
    O(.tsn, (.e, 5)) ++ R(.tsn) ++ O(.tsn, (.b, 4)) ++ O(.tsn, (.c, 5)) ++ O(.tsn, (.e, 5)) ++ O(.tsn, (.fs, 5)) ++
    O(.en, (.b, 5)) ++ O(.en, (.a, 5)) ++
    O(.qn, (.gs, 5)) ++ R(.ten) ++ O(.ten, (.fs, 5)) ++ O(.ten, (.ds, 5)) ++
    O(.ten, (.e, 5)) ++ O(.ten, (.gs, 5)) ++ O(.ten, (.c, 6))

private let phrase8 = R(.qn) ++ R(.sn) ++ O(.sn, (.ds, 6)) ++ O(.sn, (.c, 6)) ++ O(.sn, (.ds, 6)) ++
    O(.sn, (.c, 6)) ++ O(.sn, (.gs, 5)) ++ R(.sn) ++ O(.sn, (.c, 6)) ++
    O(.sn, (.gs, 5)) ++ O(.sn, (.e, 5)) ++ O(.sn, (.ds, 5)) ++ O(.sn, (.cs, 5)) ++
    O(.en, (.ds, 5)) ++ O(.sn, (.g, 5)) ++ O(.sn, (.aas, 5))

private let phrase9 = O(.sn, (.gs, 5)) ++ O(.sn, (.aas, 5)) ++ O(.sn, (.b, 5)) ++ O(.sn, (.cs, 6)) ++
    O(.en, (.ds, 6)) ++ O(.sn, (.cs, 6)) ++ O(.sn, (.g, 6)) ++
    R(.en) ++ R(.sn) ++ O(.tn, (.g, 6)) ++ O(.tn, (.f, 6)) ++
    O(.sn, (.ds, 6)) ++ O(.sn, (.cs, 6)) ++ O(.sn, (.b, 5)) ++ O(.sn, (.b, 5)) ++
    O(.sn, (.aas, 5)) ++ O(.sn, (.g, 5)) ++ O(.sn, (.gs, 5)) ++ O(.sn, (.aas, 5)) ++
    O(.sn, (.b, 5)) ++ O(.sn, (.cs, 6)) ++ O(.en, (.ds, 6))

private let phrase10 = O(.sn, (.cs, 6)) ++ O(.tn, (.b, 5)) ++ O(.tn, (.bf, 5)) ++ O(.sn, (.a, 5)) ++ O(.sn, (.af, 5)) ++
    O(.sn, (.g, 5)) ++ O(.sn, (.gf, 5)) ++ O(.sn, (.f, 5)) ++ O(.sn, (.ef, 5)) ++
    O(.qn, (.e, 5)) ++ O(.qn, (.g, 5)) ++
    O(.en, (.cs, 5)) ++ R(.sn) ++ O(.sn, (.e, 5)) ++ R(.sn) ++ O(.sn, (.cs, 5)) ++ R(.sn) ++ O(.sn, (.d, 5)) ++
    R(.sn) ++ O(.sn, (.g, 4)) ++ R(.en) ++
    O(.en, (.g, 5)) ++ O(.en, (.g, 5)) ++ O(.en, (.g, 5)) ++ O(.sn, (.fs, 5)) ++ O(.sn, (.e, 5))

let solo = phrase2 ++ phrase3 ++ phrase4 ++ phrase5 ++ phrase6 ++ phrase7 ++ phrase8 ++ phrase9 ++ phrase10
