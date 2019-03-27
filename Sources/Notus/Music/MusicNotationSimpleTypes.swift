import Foundation

public typealias Octave = UInt8
public typealias Pitch = (PitchClass, Octave)
public typealias Bpm = UInt
public typealias RelativePitch = Int8
public typealias Staff = UInt8

public typealias RelativeChange = Float
public typealias PlayerName = String

public enum PitchClass {
    case c, d, e, f, g, a, b,
    cf, df, ef, ff, gf, af, bf,
    cs, ds, es, fs, gs, aas, bs,
    cff, dff, eff, fff, gff, aff, bff,
    css, dss, ess, fss, gss, ass, bss
}

public enum Dur: CaseIterable {
    case wn     // whole note
    case hn     // half note
    case qn     // quarter note
    case en     // eighth note
    case sn     // sixteenth note
    case tn     // thirty-second note
    
    case dwn    // dotted whole note
    case dhn    // dotted half note
    case dqn    // dotted quarter note
    case den    // dotted eighth note
    case dsn    // dotted sixteenth note
    case dtn    // dotted thirty-second note
    
    case ddwn    // double-dotted whole note
    case ddhn    // double-dotted half note
    case ddqn    // double-dotted quarter note
    case dden    // double-dotted eighth note
    case ddsn    // double-dotted sixteenth note
    case ddtn    // double-dotted thirty-second note
    
    case twn     // triple whole note
    case thn     // triple half note
    case tqn     // triple quarter note
    case ten     // triple eighth note
    case tsn     // triple sixteenth note
    case ttn     // triple thirty-second note
}

public enum Ornament {
    case trill, mordent, invMordent, doubleMordent, turn, trilledTurn, shortTrill
    case arpeggio, arpeggioUp, arpeggioDown
    case instruction(String), diatonicTrans(Int)
}

public enum Loudness {
    case ppp, pp, p, mp, sf, mf, nf, ff, fff
}

public enum TempoDirection {
    case ritardando, accelerando
}

public enum Articulation {
    case staccato, legato, slurred
    case tenuto, marcato, pedal, fermata, fermataDown, breath, downBow, upBow
    case harmonic, pizzicato, leftPizz, bartokPizz, swell, wedge, thumb, stopped
}

public enum Dynamic {
    case accent
    case crescendo(RelativeChange)
    case diminuendo(RelativeChange)
    case dynamicEvolution(Loudness, Loudness)
    case loudness(Loudness)
}

public enum NoteAttribute {
    case volume(UInt8)  // MIDI convention: 0=min, 127=max
    //    case fingering(Int)
    //    case dynamics(String)
}
