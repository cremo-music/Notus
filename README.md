> Authors:
> * Nikolas Borrel (<nikolasborrel@gmail.com>)
> * Andreas Hjortgaard Danielsen (<andreashd@gmail.com>)

# Notus for Swift
Notus is a domain-specific language for expressing musical structures in the high-level, declarative style of functional programming. These musical structures consist of primitive notions such as notes and rests, operations to transform musical objects such as transpose and tempo-scaling, and operations to combine musical objects to form more complex ones, such as concurrent and sequential composition. From these simple roots, much richer musical ideas can easily be developed.

Notus is inspired by the [Euterpea project](http://www.euterpea.com) implemented in Haskell.

## Notus in Detail
In Notus, the representation of musical structures is done with the Music data type, and the semantics (or interpretation) is done by transforming Music to the Performance data type, from where it is possible to export to MIDI, CSound or other low-level representation (only MIDI export is currently available).

Let's start by looking at the pitch type, which consists of a `Pitch` and the `Octave` in which the pitch is defined:
```swift
public enum PitchClass {
    case c, d, e, f, g, a, b,
    cf, df, ef, ff, gf, af, bf,
    cs, ds, es, fs, gs, aas, bs,
    cff, dff, eff, fff, gff, aff, bff,
    css, dss, ess, fss, gss, ass, bss
}
public typealias Octave = UInt8
public typealias Pitch = (PitchClass, Octave)
```

The `PitchClass` data type declares all 12 semitone by 35 pitch class names. For a reference, the notion of "the concert key A" is denoted `(.a, 4)` in the above design.
The representation of musical structures is done with the `Music` type:
```swift
public enum Music {
    case prim(Primitive)
    indirect case stack(Music, Music)
    indirect case seq(Music, Music)
    indirect case modify(Control, Music)
}
public enum Primitive {
    case note(Dur, Pitch)
    case noteAttr(Dur, Pitch, [NoteAttribute])
    case rest(Dur)
    case none
}
public enum Control {
    case tempo(Bpm)
    case volume(Vol)
    case transpose(RelativePitch)
    case staff(Staff)
    case player(PlayerName)
    case interpret([PhraseAttribute])
}
public typealias PlayerName = String
```

A `note` is defined by a duration and a pitch, where a `rest` only has a duration. The duration is defining whole notes (`.wn`), half notes (`.hn`) and so on. To spare your fragile fingers, some syntactical sugar has been springled upon the Notus language like so: `O(.qn, (.a, 4))` for a quarter note with pitch A in octave 4, and `R(.wn)` for a whole note rest.

With these building blocks, we can build more complex musical structures as follows:

  * `m1 ++ m2` is the **sequencial composition** of `m1` and `m2`, i.e. `m1` and `m2` are played in sequence.
  * `m1 |=| m2` is the **parallel composition** of `m1` and `m2`, i.e. `m1` and `m2` are played simultaneously.
  * `tempo(Bpm) => music` sets the tempo `Bpm` of `music`.
  * `volume(Vol) => music` sets the volume `Vol` of `music`.
  * `transpose(RelativePitch) => music` transposes `music` by an interval `RelativePitch` measured in semitones.
  * `staff(Staff) => music` places `music` in staff `Staff`.
  * `interpret([PhraseAttribute]) => music` sets various attributes related to the subjective interpretation of `music`, such as dynamics and articulation.

A simple example using these constructors is shown below:

```swift
let dMajor: Notes = notes((.d, 4), (.fs, 4), (.a, 4))
let gMinor: Notes = notes((.d, 4), (.g, 4), (.bf, 4))

let dMajorMelody1: Music =
    O(.en, (.d, 5)) ++ O(.en, (.d, 5)) ++ O(.en, (.d, 5))
        ++ O(.en, (.e, 5))
        ++ O(.en, (.fs, 5)) ++ O(.en, (.fs, 5)) ++ O(.qn, (.fs, 5))

let dMajorMelody2: Music =
    O(.en, (.e, 5)) ++ O(.en, (.d, 5)) ++ O(.en, (.e, 5))
        ++ O(.en, (.fs, 5))
        ++ R(.qn) ++ O(.qn, (.d, 5))

let melody = dMajorMelody1 ++ dMajorMelody2
let harmony = dMajor.stack(.wn) ++ gMinor.stack(.hn) ++ dMajor.stack(.hn)

let music = melody |=| harmony

let upm = try UserPatchMap([(0, .ch0, .acousticGrandPiano)])

let piece = .staff(0) => .tempo(60) => music
```

## Project Overview
The **Notus** framework is grouped into 2 parts:
  * **Notus** contains building blocks for describing musical structures and can be used on Apple and Linux platforms.
  * **NotusIO** contains functionality for converting from Notus to MIDI and vice versa, currently available only on the Apple platforms.

**NotusDemoHost** is an iOS demo project showing some Notus music examples.

### Notus Framework structure
The following files are a good starting point to get used to the strange, recursive world of Notus:

```verbatim
├── Sources
│   └── Notus
│       ├── MusicExamples
│       │   ├── Canine
│       │   ├── Chameleon.swift
│       │   ├── DrumSolo.swift
│       │   ├── James.swift
│       ├── MusicNotation.swift: The Notus domain-specific language
│       ├── NotusIO
│       │   ├── Midi
│       │   │   ├── MidiToMusic.swift: Convert from Midi to Music
│       │   │   ├── MusicToMidi.swift: Convert from Music to Midi
│       │   └── Playback
│       │       └── MidiPlayer.swift: Playback Midi
│       └── Performance
│           ├── MusicToPerformance.swift: conversion from Music to Performance
│           ├── Performance.swift: defines constructs for describing music as `Performance`, the most low-level representation available in Notus. This representation can then be transformed from `Performance` to Midi or other formats.
│           ├── UserPatchMap.swift: defines mappings between `Staff`, `Channel` and `Instrument`
│           ├── Players
│           │   ├── DefaultPlayer.swift: simple player handling (some) interpretations
│           │   └── FancyPlayer.swift: more advanced player handling dynamics, articulations and tempos
```

## Installation
### Swift Package Manager

The Swift Package Manager is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

Once you have your Swift package set up, adding Notus as a dependency is done by adding the package URL to your Package.swift.

**Swift 5**
```swift
dependencies: [
    .package(url: "https://github.com/cremo-music/Notus.git", from: "1.0.0")
]
```


## Running
There are a number of examples showing how Notus can be used. There are two ways to run the NotusDemoHost project:

### XCode
Open the workspace for NotusDemoHost called `NotusDemoHost.xcworkspace` inside the `NotusDemoHost` folder and simply run the project on an iOS device.

To run on iOS with proper MIDI sounds, you need a soundfont. We recommend the Airfont 340, which you can download [here](https://www.ronimusic.com/smp_ios_dls_files.htm). This file should be placed in the `Resources` folder as usual.

### Command line
Open a Terminal and go to the `NotusDemoHost` folder. To run:
```bash
swift run
```
On MacOS this will generate a number a MIDI example files in the Documents folder on your Mac.
On Linux, it will print out an example in Notus language.

## Known issues

* Importing triplets from MIDI files results in empty duration when the triplet contains identical pitches.

## Start Contributing

This is an open-source project, please contact us if you are interested in contributing!

## License
See [LICENSE](LICENSE)
