import Foundation

public let defaultPlayerName = "default"
let defaultPlayer = Player (
    name: defaultPlayerName,
    noteInterpret: playerNoteInterpret(defPlayerNoteAttributeHandler),
    phraseInterpret: phraseInterpret(defPhaseInterpretHandler)
)

private let defPlayerNoteAttributeHandler = {(event: Event, attr: NoteAttribute) -> Event in
    var updatedEvent = event
    
    switch (attr)
    {
    case .volume(let value):
        updatedEvent.vol = value
    }
    
    return updatedEvent
}

private let defPhaseInterpretHandler = {(events: [Event], phraseAttr: PhraseAttribute) -> [Event] in
    var updatedEvents = events
    
    switch phraseAttr {
    case .dynamic(.accent):
        updatedEvents = updatedEvents.map{
            var event = $0
            event.vol = UInt8(min(127, 1.5 * Float($0.vol)))
            return event
        }
    case .articulation(.staccato):
        updatedEvents = updatedEvents.map{
            var event = $0
            event.dur = 0.5 * $0.dur
            return event
        }
    case .articulation(.legato):
        updatedEvents = updatedEvents.map{
            var event = $0
            event.dur = 1.2 * $0.dur
            return event
        }
    default:
        break
    }
    
    return updatedEvents
}
