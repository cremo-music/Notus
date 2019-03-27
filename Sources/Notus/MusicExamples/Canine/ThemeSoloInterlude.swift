import Foundation

let themeFinal = R(.sn) ++ O(.sn, (.a, 4)) ++ O(.sn, (.b, 4)) ++ R(.sn) ++ R(.qn)

let soloIterlude1: Music = themeFinal ++
    O(.sn, (.g, 5)) ++ O(.sn, (.f, 5)) ++ O(.sn, (.d, 5)) ++ O(.sn, (.cs, 5)) ++
    O(.sn, (.d, 5)) ++ O(.sn, (.g, 5)) ++ O(.sn, (.cs, 5)) ++ O(.sn, (.c, 5)) ++
    O(.sn, (.aas, 4)) ++ O(.sn, (.c, 5)) ++ O(.sn, (.cs, 5)) ++ O(.sn, (.d, 5)) ++
    O(.sn, (.f, 5)) ++ O(.sn, (.g, 5)) ++ R(.sn) ++ O(.sn, (.aas, 5)) ++
    R(.sn) ++ O(.sn, (.b, 5)) ++ R(.sn) ++ O(.sn, (.c, 6)) ++
    R(.sn) ++ O(.sn, (.cs, 6)) ++ R(.sn) ++ O(.sn, (.d, 6))

let bassInterlude1 = G.stack(.hn)
let chordsInterlude1 = G7.stack(.hn)

let chordsInterlude2 = G7.stack(.wn)
let bassInterlude2 = G.stack(.wn)
