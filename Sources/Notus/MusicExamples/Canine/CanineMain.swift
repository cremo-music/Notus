import Foundation

public func canine() throws -> (Music, UserPatchMap) {
    
    // SET ATTRIBUTES
    
    // theme
    let themeMusic = .staff(0) => .transpose(-12) => theme
    let themeUpbeatFullBarMusic = .staff(0) => .transpose(-12) => themeUpbeatFullBar
    let themeFinalMusic = .staff(0) => .transpose(-12) => themeFinal
    
    let chordsThemeMusic = .staff(1) => .volume(32) => chordsTheme
    let bassThemeMusic = .staff(2) => bassTheme
    
    // interlude
    let themeUpbeatInterlude2Music = .staff(0) => .transpose(-12) => themeUpbeatFullBar
    let soloIterlude1Music = .staff(0) => .transpose(-12) => soloIterlude1
    
    let chordsInterlude1Music = .staff(1) => .volume(32) => chordsInterlude1
    let chordsInterlude2Music = .staff(1) => .volume(32) => chordsInterlude2
    
    let bassInterlude1Music = .staff(2) => bassInterlude1
    let bassInterlude2Music = .staff(2) => bassInterlude2
    
    // solo
    let soloMusic = .staff(0) => .transpose(-12) => solo
    let chordsSoloMusic = .staff(1) => .volume(32) => chordsSolo
    let bassSoloMusic = .staff(2) => bassSolo
    
    // create music
    let music =  .tempo(96) => themeUpbeatFullBarMusic ++
        (themeMusic |=| chordsThemeMusic |=| bassThemeMusic) ++
        (soloIterlude1Music |=| chordsInterlude1Music |=| bassInterlude1Music) ++
        (soloMusic |=| chordsSoloMusic |=| bassSoloMusic) ++
        (themeUpbeatInterlude2Music |=| chordsInterlude2Music |=| bassInterlude2Music) ++
        (themeMusic |=| chordsThemeMusic |=| bassThemeMusic) ++
        themeFinalMusic
    
    let upm = try UserPatchMap([(0, .ch0, .electricJazzGuitar), (1, .ch1, .hammondOrgan), (2, .ch2, .fingeredElectricBass)])
    
    return (music, upm)
}
