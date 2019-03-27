import Foundation

public let fancyPlayerName = "fancy"
let fancyPlayer = Player (
    name: fancyPlayerName,
    noteInterpret: playerNoteInterpret(fancyPlayerNoteAttributeHandler),
    phraseInterpret: phraseInterpret(fancyPhaseInterpretHandler)
)

private let fancyPlayerNoteAttributeHandler = {(event: Event, attr: NoteAttribute) -> Event in
    var updatedEvent = event
    
    switch (attr)
    {
    case .volume(let value):
        updatedEvent.vol = value
    }
    
    return updatedEvent
}

private let fancyPhaseInterpretHandler = {(events: [Event], phraseAttr: PhraseAttribute) -> [Event] in
    
    switch phraseAttr {
    case .dynamic(.accent):
        return accent(events: events)
    case .dynamic(.loudness(let l)):
        return setVol(vol: l.toVol(), events: events)
    case .dynamic(.dynamicEvolution(let from, let to)):
        return inflateAbs(fromVol: from.toVol(), toVol: to.toVol(), events: events)
    case .dynamic(.crescendo(let factor)):
        return inflateRel(factor: factor, events: events)
    case .dynamic(.diminuendo(let factor)):
        return inflateRel(factor: 1/factor, events: events)
    case .articulation(.staccato):
        return noteBinder(x: -0.2, events: events)
    case .articulation(.legato):
        return noteBinder(x: 0.2, events: events)
    case .articulation(.slurred):
        return slurred(events: events)
    case .tempo(.ritardando):
        return stretch(x: 0.2, events: events)
    case .tempo(.accelerando):
        return stretch(x: -0.2, events: events)
    default:
        return events
    }
}

extension Loudness {
    func toVol() -> UInt8
    {
        switch self {
        case .ppp: return 30; case .pp: return 45;   case .p:   return 60
        case .mp:  return 70; case .sf: return 80;   case .mf:  return 90
        case .nf:  return 100; case .ff: return 110; case .fff: return 127
        }
    }
}

extension Array where Element == Event {
    func dur(includeDurationOnLastEvent: Bool) -> DurT
    {
        guard let minStartTime = self.min(by: { (e0, e1) -> Bool in
            e0.time < e1.time
        }) else {
            return 0
        }
        
        guard let maxStartTime = self.max(by: { (e0, e1) -> Bool in
            e0.time < e1.time
        }) else {
            return 0
        }
        
        let lastMaxDuration = self.filter({ (e) -> Bool in
            e.time == maxStartTime.time
        }).max { (e0, e1) -> Bool in
            e0.dur < e1.dur
        }
        
        return DurT(maxStartTime.time - minStartTime.time) + (includeDurationOnLastEvent ? lastMaxDuration!.dur : 0)
    }
}

private func accent(events: [Event]) -> [Event] {
    return events.map{
        var event = $0
        event.vol = UInt8(1.5 * Float($0.vol))
        return event
    }
}

private func slurred(events: [Event]) -> [Event] {
    let lastStartTime = events.reduce(0, {(result, event) -> Double in
        return max(event.time, Double(result))
    })
    
    let setDur = { (event: Event) -> Event in
        var eOut = event
        eOut.dur = event.time < lastStartTime ? 1.2 * event.dur : event.dur
        return eOut
    }
    
    return events.map(setDur)
}

private func setVol(vol: UInt8, events: [Event]) -> [Event]
{
    return events.map{
        var event = $0
        event.vol = vol
        return event
    }
}

// x interval: ]-1,inf]
private func stretch(x: Double, events: [Event]) -> [Event]
{
    let totalDur = events.dur(includeDurationOnLastEvent: true)
    let t0 = events[0].time
    let stepFactor = x / totalDur
    
    let tempoChange = {(event: Event) -> Event in
        let eventDur = event.dur
        let t = event.time
        let dt = Double(t - t0)
        
        let stretchedTime = (1 + dt * stepFactor)*dt + t0
        let stretchedDur = (1 + (2*dt + eventDur) * stepFactor) * eventDur
        
        var eMod = event
        eMod.time = Double(stretchedTime)
        eMod.dur = stretchedDur
        
        return eMod
    }
    
    return events.map(tempoChange)
}

private func inflateAbs(fromVol: UInt8, toVol: UInt8, events: [Event]) -> [Event]
{
    if events.count == 0 {
        return []
    }

    let dur = events.dur(includeDurationOnLastEvent: false)
    let t0 = events[0].time
    let stepVol = dur == 0 ? Double(fromVol) : (Double(toVol) - Double(fromVol)) / dur
    
    let dynam = {(event: Event) -> Event in
        var e = event; let t = event.time
        e.vol = UInt8(round( Double(fromVol) + Double(t-t0) * stepVol ))
        return e
    }
    
    return events.map(dynam)
}

// factor interval: [0,inf[
private func inflateRel(factor: RelativeChange, events: [Event]) -> [Event]
{
    let fromVol = events[0].vol
    let toVol_ = round(Float(fromVol) * factor)
    let toVol = UInt8(max(0, min(toVol_, 127)))
    
    return inflateAbs(fromVol: fromVol, toVol: toVol, events: events)
}

// x interval: [-1,inf[
private func noteBinder(x: Double, events: [Event]) -> [Event]
{
    return events.map{
        var event = $0
        event.dur = $0.dur * (1 + x)
        return event
    }
}
