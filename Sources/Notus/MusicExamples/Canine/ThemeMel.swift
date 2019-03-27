import Foundation

//
// THEME
//

// melody
let themeUpbeat = R(.sn) ++ O(.sn, (.b, 5)) ++ O(.sn, (.b, 5)) ++ R(.sn)
let themeUpbeatFullBar = R(.dhn) ++ themeUpbeat

private let themeA: Music = O(.qn, (.fs, 6)) ++ O(.en, (.e, 6)) ++ O(.en, (.b, 5)) ++
    O(.sn, (.ds, 6)) ++ O(.sn, (.e, 6)) ++ O(.en, (.g, 6)) ++
    R(.sn) ++ O(.den, (.f, 6)) ++
    O(.dqn, (.d, 6)) ++ R(.sn) ++ O(.sn, (.c, 6)) ++
    O(.sn, (.a, 5)) ++ O(.sn, (.aas, 5)) ++ O(.sn, (.cs, 6)) ++ O(.den, (.ds, 6)) ++ O(.sn, (.cs, 6)) ++ O(.sn, (.b, 5))

private let themeAInterlude = R(.hn) ++ O(.sn, (.d, 6)) ++ O(.sn, (.gs, 5)) ++ O(.sn, (.b, 5)) ++ O(.sn, (.d, 5)) ++
    R(.qn) ++ R(.sn) ++ O(.den, (.b, 4)) ++ O(.qn, (.d, 5)) ++
    O(.sn, (.b, 4)) ++ O(.sn, (.a, 4)) ++ O(.sn, (.fs, 4)) ++ R(.sn)

private let themeAInterlude2Voice1 = R(.sn) ++ O(.den, (.e, 6)) ++ O(.qn, (.ds, 6)) ++
    O(.hn, (.d, 6)) ++
    R(.en) ++ O(.en, (.cs, 6)) ++ R(.sn) ++ O(.den, (.c, 6)) ++
    O(.qn, (.b, 5)) ++ R(.sn) ++ O(.sn, (.g, 4)) ++ O(.sn, (.a, 4)) ++ O(.sn, (.g, 4)) ++
    O(.hn, (.gs, 4)) ++
    R(.sn) ++ O(.sn, (.g, 4)) ++ R(.en) ++
    O(.sn, (.a, 4)) ++ O(.tn, (.aas, 4)) ++ O(.tn, (.a, 4)) ++ O(.sn, (.g, 4)) ++ O(.sn, (.e, 4)) ++ // bindebue!
    R(.qn) ++ O(.en, (.g, 4)) ++ R(.en) ++
    R(.hn)

private let themeAInterlude2Voice2 = R(.sn) ++ O(.den, (.gs, 5)) ++ O(.qn, (.g, 5)) ++
    O(.dqn, (.fs, 5)) ++ R(.sn) ++ O(.sn, (.ds, 5)) ++
    O(.qn, (.e, 5)) ++ R(.sn) ++ O(.den, (.ds, 5)) ++
    O(.qn, (.d, 5))

private let themeAInterlude2 = themeAInterlude2Voice1 |=| themeAInterlude2Voice2

private let themeBPart1 = O(.sn, (.a, 6)) ++ O(.den, (.d, 6)) ++ O(.sn, (.b, 5)) ++ O(.den, (.gs, 5)) ++
    R(.qn) ++ R(.den) ++ O(.sn, (.gs, 5)) ++ R(.sn) ++ O(.sn, (.b, 5)) ++ R(.sn) ++ O(.sn, (.gs, 5)) ++
    O(.en, (.d, 6)) ++ O(.en, (.d, 6)) ++
    R(.qn) ++ R(.en) ++ O(.sn, (.f, 6)) ++ O(.sn, (.e, 6)) ++
    R(.en) ++ O(.sn, (.b, 5)) ++ O(.sn, (.b, 5)) ++
    O(.sn, (.d, 6)) ++ O(.en, (.e, 6)) ++ O(.sn, (.d, 6)) ++
    R(.sn) ++ O(.en, (.b, 5)) ++ R(.sn) ++
    O(.en, (.gs, 5)) ++ O(.sn, (.b, 5)) ++ O(.sn, (.gs, 5)) ++
    O(.sn, (.d, 6)) ++ O(.sn, (.b, 5)) ++ O(.en, (.gs, 5)) ++ O(.en, (.b, 5)) ++ R(.en)

private let themeBPart2 = R(.qn) ++ R(.den) ++ O(.sn, (.a, 6)) ++
    R(.qn) ++ O(.en, (.a, 6)) ++ R(.en) ++
    R(.sn) ++ O(.sn, (.b, 5)) ++ R(.en) ++
    O(.en, (.d, 6)) ++ O(.sn, (.e, 6)) ++ O(.sn, (.d, 6)) ++
    R(.sn) ++ O(.sn, (.a, 6)) ++ R(.en) ++
    O(.en, (.d, 6)) ++ R(.en) ++
    O(.sn, (.gs, 5)) ++ O(.sn, (.d, 6)) ++ O(.en, (.b, 5)) ++ R(.qn)

private let themeBPart3 = R(.sn) ++ O(.en, (.b, 5)) ++ R(.sn) ++
    O(.en, (.d, 6)) ++ O(.sn, (.e, 6)) ++ O(.sn, (.d, 6)) ++
    O(.sn, (.a, 6)) ++ O(.sn, (.b, 5)) ++ R(.sn) ++ O(.sn, (.d, 6)) ++
    R(.den) ++ O(.sn, (.e, 6)) ++
    O(.tn, (.e, 6)) ++ O(.tn, (.f, 6)) ++ O(.tn, (.e, 6)) ++ O(.tn, (.d, 6)) ++ O(.sn, (.e, 6)) ++ O(.sn, (.b, 5)) ++
    O(.sn, (.d, 6)) ++ O(.sn, (.b, 5)) ++ O(.en, (.a, 5)) ++
    O(.sn, (.b, 5)) ++ O(.sn, (.a, 5)) ++ O(.tn, (.f, 5)) ++ O(.tn, (.e, 5)) ++ O(.tn, (.d, 5)) ++ R(.tn) ++
    O(.sn, (.e, 5)) ++ O(.sn, (.d, 5)) ++ R(.sn) ++ O(.sn, (.b, 4))

private let themeB = themeBPart1 ++ themeBPart2 ++ themeBPart3

let theme = themeA ++ themeAInterlude ++ themeUpbeat ++ themeA ++ themeAInterlude2 ++ themeB
