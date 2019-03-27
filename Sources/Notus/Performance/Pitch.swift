import Foundation

extension PitchClass {
    
    func toInt() -> Int {
        var val: Int
        switch self {
        case .cff:              val = -2
        case .cf:               val = -1
        case .c, .dff:          val = 0
        case .cs, .df:          val = 1
        case .css, .d, .eff:    val = 2
        case .ds, .ef, .fff:    val = 3
        case .dss, .e, .ff:     val = 4
        case .es, .f, .gff:     val = 5
        case .ess, .fs, .gf:    val = 6
        case .fss, .g, .aff:    val = 7
        case .gs, .af:          val = 8
        case .gss, .a, .bff:    val = 9
        case .aas, .bf:         val = 10
        case .ass, .b:          val = 11
        case .bs:               val = 12
        case .bss:              val = 13
        }
        return val
    }
    
    func toAbsPitch(octave: UInt8) -> AbsPitch {
        let pitchClassValue = self.toInt()
        let absPitch = AbsPitch(12 * (Int(octave) + 1) + pitchClassValue)
        return absPitch
    }
    
    static func fromAbsPitch(_ absPitch: AbsPitch) -> Pitch {
        let (octave, pitchValue) = absPitch.quotientAndRemainder(dividingBy: 12)
        let allnotes: [PitchClass] = [.c, .cs, .d, .ds, .e, .f, .fs, .g, .gs, .a, .aas, .b]
        let pitchclass = allnotes[Int(pitchValue)]
        return (pitchclass, octave - 1)
    }
}
