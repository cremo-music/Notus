import Foundation

// chords
private let theme1Chords = B7.stack(.hn) ++ G7.stack(.hn) ++ F7.stack(.hn) ++ Fs7.stack(.hn) ++ B7.stack(.wn).repeated(1)
private let theme2Chords = B7.stack(.hn) ++ GsTriad.stack(.hn) ++ F7.stack(.hn) ++ Fs7.stack(.hn) ++ E7.stack(.wn).repeated(3)

let chordsTheme = theme1Chords ++ theme2Chords

// bass
private let bassTheme1 = B.stack(.hn) ++ G.stack(.hn) ++ F.stack(.hn) ++ Fs.stack(.hn) ++ B.stack(.wn).repeated(1)
private let bassTheme2 = B.stack(.hn) ++ Gs.stack(.hn) ++ F.stack(.hn) ++ Fs.stack(.hn) ++ E.stack(.wn).repeated(3)
private let bassTheme3 = E.stack(.sn).repeated(7).repeated(7).repeated(1)

let bassTheme = bassTheme1 ++ bassTheme2 ++ bassTheme3
