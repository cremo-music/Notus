import Foundation

// chords
let B7 = notes((.b, 3), (.a, 4), (.ds, 4), (.fs, 4))
let D7 = notes((.d, 3), (.c, 4), (.fs, 4), (.a, 4))
let A7 = notes((.a, 3), (.g, 4), (.cs, 4), (.e, 4))
let E7 = notes((.e, 3), (.d, 4), (.gs, 4), (.b, 4))

let Csm7 = notes((.cs, 3), (.fs, 4), (.b, 4), (.e, 5))

let F7 = notes((.f, 3), (.ds, 4), (.a, 4), (.c, 4))
let Fs7sharp9 = notes((.fs, 3), (.aas, 4), (.e, 5), (.a, 5))
let Fs7 = notes((.fs, 3), (.e, 4), (.ass, 4), (.cs, 5))

let G7 = notes((.g, 3), (.f, 4), (.b, 4), (.d, 4))
let Gs7_sharp9 = notes((.gs, 3), (.c, 4), (.fs, 4), (.b, 4))
let Gsm7 = notes((.gs, 3), (.fs, 4), (.b, 4), (.ds, 4))
let GsTriad = notes((.gs, 3), (.c, 4), (.ds, 4))

let Asm7b5 = notes((.aas, 3), (.gs, 4), (.cs, 4), (.e, 4))
let Ds7sharp9 = notes((.ds, 3), (.g, 4), (.cs, 4), (.fs, 4))

// bass
let oBass: Octave = 2
let B = notes((.b, 1))
let D = notes((.d, oBass))
let Ds = notes((.ds, oBass))
let A = notes((.a, oBass))
let E = notes((.e, 1))
let Cs = notes((.cs, oBass))
let F = notes((.f, oBass))
let Fs = notes((.fs, oBass))
let As = notes((.aas, oBass))
let G = notes((.g, oBass))
let Gs = notes((.gs, oBass))
