import Foundation

public enum Instrument: UInt8 {
    
    // Piano
    case acousticGrandPiano = 1
    case brightAcousticPiano = 2
    case electricGrandPiano = 3
    case honkyTonkPiano = 4
    case rhodesPiano = 5
    case chorusedPiano = 6
    case harpsichord = 7
    case clavinet = 8
    
    // Chromatic Percussion
    case celesta = 9
    case glockenspiel = 10
    case musicBox = 11
    case vibraphone = 12
    case marimba = 13
    case xylophone = 14
    case tubularBells = 15
    case dulcimer = 16
    
    // Organ
    case hammondOrgan = 17
    case percussiveOrgan = 18
    case rockOrgan = 19
    case churchOrgan = 20
    case reedOrgan = 21
    case accordion = 22
    case harmonica = 23
    case tangoAccordion = 24
    
    // Guitar
    case acousticNylonGuitar = 25
    case acousticSteelGuitar = 26
    case electricJazzGuitar = 27
    case electricCleanGuitar = 28
    case electricMutedGuitar = 29
    case overdrivenGuitar = 30
    case distortionGuitar = 31
    case guitarHarmonics = 32
    
    // Bass
    case acousticBass = 33
    case fingeredElectricBass = 34
    case pluckedElectricBass = 35
    case fretlessBass = 36
    case slapBass1 = 37
    case slapBass2 = 38
    case synthBass1 = 39
    case synthBass2 = 40
    
    // Strings
    case violin = 41
    case viola = 42
    case cello = 43
    case contrabass = 44
    case tremoloStrings = 45
    case pizzicatoStrings = 46
    case orchestralHarp = 47
    case timpani = 48
    
    // Ensemble
    case stringEnsemble1 = 49
    case stringEnsemble2 = 50
    case synthStrings1 = 51
    case synthStrings2 = 52
    case choirAah = 53
    case choirOoh = 54
    case synthVoice = 55
    case orchestralHit = 56
    
    // Brass
    case trumpet = 57
    case trombone = 58
    case tuba = 59
    case mutedTrumpet = 60
    case frenchHorn = 61
    case brassSection = 62
    case synthBrass1 = 63
    case synthBrass2 = 64
    
    // Reed
    case sopranoSax = 65
    case altoSax = 66
    case tenorSax = 67
    case baritoneSax = 68
    case oboe = 69
    case englishHorn = 70
    case bassoon = 71
    case clarinet = 72
    
    // Pipe
    case piccolo = 73
    case flute = 74
    case recorder = 75
    case panFlute = 76
    case bottleBlow = 77
    case shakuhachi = 78
    case whistle = 79
    case ocarina = 80
    
    // Synth Lead
    case squareWaveLead = 81
    case sawtoothWaveLead = 82
    case calliopeLead = 83
    case chiffLead = 84
    case charangLead = 85
    case voiceLead = 86
    case fifthsLead = 87
    case bassLead = 88
    
    // Synth Pad
    case newAgePad = 89
    case warmPad = 90
    case polysynthPad = 91
    case choirPad = 92
    case bowedPad = 93
    case metallicPad = 94
    case haloPad = 95
    case sweepPad = 96
    
    // Synth Effects
    case rainEffect = 97
    case soundtrackEffect = 98
    case crystalEffect = 99
    case atmosphereEffect = 100
    case brightnessEffect = 101
    case goblinsEffect = 102
    case echoesEffect = 103
    case sciFiEffect = 104
    
    // Ethnic
    case sitar = 105
    case banjo = 106
    case shamisen = 107
    case koto = 108
    case kalimba = 109
    case bagpipe = 110
    case fiddle = 111
    case shanai = 112
    
    // Percussive
    case tinkleBell = 113
    case agogo = 114
    case steelDrums = 115
    case woodblock = 116
    case taikoDrum = 117
    case melodicTom = 118
    case synthDrum = 119
    case reverseCymbal = 120
    
    
    // Sound effects
    case guitarFretNoise = 121
    case breathNoise = 122
    case seashore = 123
    case birdTweet = 124
    case telephoneRing = 125
    case helicopter = 126
    case applause = 127
    case gunShot = 128
    
    // Percussion (dummy instrument, not part of General MIDI)
    case percussion = 129
}


public func instrumentFromRawValue(_ inst: UInt8) -> Instrument? {
    
    switch inst {
    case 1: return .acousticGrandPiano
    case 2: return .brightAcousticPiano
    case 3: return .electricGrandPiano
    case 4: return .honkyTonkPiano
    case 5: return .rhodesPiano
    case 6: return .chorusedPiano
    case 7: return .harpsichord
    case 8: return .clavinet
    case 9: return .celesta
    case 10: return .glockenspiel
    case 11: return .musicBox
    case 12: return .vibraphone
    case 13: return .marimba
    case 14: return .xylophone
    case 15: return .tubularBells
    case 16: return .dulcimer
    case 17: return .hammondOrgan
    case 18: return .percussiveOrgan
    case 19: return .rockOrgan
    case 20: return .churchOrgan
    case 21: return .reedOrgan
    case 22: return .accordion
    case 23: return .harmonica
    case 24: return .tangoAccordion
    case 25: return .acousticNylonGuitar
    case 26: return .acousticSteelGuitar
    case 27: return .electricJazzGuitar
    case 28: return .electricCleanGuitar
    case 29: return .electricMutedGuitar
    case 30: return .overdrivenGuitar
    case 31: return .distortionGuitar
    case 32: return .guitarHarmonics
    case 33: return .acousticBass
    case 34: return .fingeredElectricBass
    case 35: return .pluckedElectricBass
    case 36: return .fretlessBass
    case 37: return .slapBass1
    case 38: return .slapBass2
    case 39: return .synthBass1
    case 40: return .synthBass2
    case 41: return .violin
    case 42: return .viola
    case 43: return .cello
    case 44: return .contrabass
    case 45: return .tremoloStrings
    case 46: return .pizzicatoStrings
    case 47: return .orchestralHarp
    case 48: return .timpani
    case 49: return .stringEnsemble1
    case 50: return .stringEnsemble2
    case 51: return .synthStrings1
    case 52: return .synthStrings2
    case 53: return .choirAah
    case 54: return .choirOoh
    case 55: return .synthVoice
    case 56: return .orchestralHit
    case 57: return .trumpet
    case 58: return .trombone
    case 59: return .tuba
    case 60: return .mutedTrumpet
    case 61: return .frenchHorn
    case 62: return .brassSection
    case 63: return .synthBrass1
    case 64: return .synthBrass2
    case 65: return .sopranoSax
    case 66: return .altoSax
    case 67: return .tenorSax
    case 68: return .baritoneSax
    case 69: return .oboe
    case 70: return .englishHorn
    case 71: return .bassoon
    case 72: return .clarinet
    case 73: return .piccolo
    case 74: return .flute
    case 75: return .recorder
    case 76: return .panFlute
    case 77: return .bottleBlow
    case 78: return .shakuhachi
    case 79: return .whistle
    case 80: return .ocarina
    case 81: return .squareWaveLead
    case 82: return .sawtoothWaveLead
    case 83: return .calliopeLead
    case 84: return .chiffLead
    case 85: return .charangLead
    case 86: return .voiceLead
    case 87: return .fifthsLead
    case 88: return .bassLead
    case 89: return .newAgePad
    case 90: return .warmPad
    case 91: return .polysynthPad
    case 92: return .choirPad
    case 93: return .bowedPad
    case 94: return .metallicPad
    case 95: return .haloPad
    case 96: return .sweepPad
    case 97: return .rainEffect
    case 98: return .soundtrackEffect
    case 99: return .crystalEffect
    case 100: return .atmosphereEffect
    case 101: return .brightnessEffect
    case 102: return .goblinsEffect
    case 103: return .echoesEffect
    case 104: return .sciFiEffect
    case 105: return .sitar
    case 106: return .banjo
    case 107: return .shamisen
    case 108: return .koto
    case 109: return .kalimba
    case 110: return .bagpipe
    case 111: return .fiddle
    case 112: return .shanai
    case 113: return .tinkleBell
    case 114: return .agogo
    case 115: return .steelDrums
    case 116: return .woodblock
    case 117: return .taikoDrum
    case 118: return .melodicTom
    case 119: return .synthDrum
    case 120: return .reverseCymbal
    case 121: return .guitarFretNoise
    case 122: return .breathNoise
    case 123: return .seashore
    case 124: return .birdTweet
    case 125: return .telephoneRing
    case 126: return .helicopter
    case 127: return .applause
    case 128: return .gunShot
    case _: return nil
    }
    
}
