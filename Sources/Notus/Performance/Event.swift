import Foundation

public struct Event {
    public init(pitch: AbsPitch, ch: Channel, instr: Instrument, vol: Vol, time: Time, dur: DurT)
    {
        self.pitch = pitch
        self.ch = ch
        self.instr = instr
        self.vol = vol
        self.time = time
        self.dur = dur
    }
    
    public var pitch: AbsPitch
    public var ch: Channel
    public var instr: Instrument
    public var vol: Vol
    public var time: Time
    public var dur: DurT
}


extension Music {
    public static func fromEvent(_ event: Event) -> Music {
        let pitch: Pitch = PitchClass.fromAbsPitch(event.pitch)
        let durs: [Dur] = Dur.toNotusDurations(event.dur)
        let vol: Vol = event.vol
        let notes: [Music] = durs.map({ (dur: Dur) -> Music in
            return .prim(.noteAttr(dur, pitch, [NoteAttribute.volume(vol)]))
        })
        return line(notes)
    }
}
