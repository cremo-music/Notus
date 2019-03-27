import Foundation

public typealias Performance = ([Event], [PerformanceContext])
public typealias Time = Float64
public typealias Vol = UInt8
public typealias Chan = Int
public typealias AbsPitch = UInt8
public typealias PlayerMap = (String) -> Player

public struct Player {
    public var name: String
    var noteInterpret: (MusicContext, Pitch, Dur, [NoteAttribute]) -> Event
    var phraseInterpret: (MusicContext, Music, PlayerMap, [PhraseAttribute]) -> Performance
}

public struct PerformanceContext {
    public init(tempo: Bpm, time: Time){
        self.tempo = tempo
        self.time = time
    }
    
    public var tempo: Bpm
    public var time: Time
}

public struct MusicContext {
    public init(player: Player, vol: Vol, beat: Time, transpose: Int8, staff: Staff, userPatchMap: UserPatchMap) {
        self.player = player
        self.beat = beat
        self.transpose = transpose
        self.staff = staff
        self.userPatchMap = userPatchMap
        self.absTime = 0
        self.vol = vol
    }
    
    public var player: Player
    public var beat: Time
    public var transpose: Int8
    public var staff: Staff
    public var userPatchMap: UserPatchMap
    public var absTime: Time
    public var vol: Vol
}

typealias NoteAttributeHandlerFun = (Event, NoteAttribute) -> Event
typealias PhraseAttributeHandlerFun = ([Event], PhraseAttribute) -> [Event]

func playerNoteInterpret(_ noteAttrHandler: @escaping NoteAttributeHandlerFun) -> ((MusicContext, Pitch, Dur, [NoteAttribute]) -> Event) {
    
    return { (context: MusicContext, pitchClass: Pitch, dur: Dur, attrs: [NoteAttribute]) -> Event in
        let noteNumber = pitchClass.0.toAbsPitch(octave: pitchClass.1)
        let noteNumberTransposed = UInt8((Int(noteNumber) + Int(context.transpose)) % 128)
        let (ch, instr) = context.userPatchMap[context.staff]!
        
        let initEvent = Event(pitch: noteNumberTransposed, ch: ch, instr: instr,
                              vol: context.vol, time: context.absTime + context.beat, dur: dur.toNotusDuration())
        
        return attrs.reduce(initEvent, noteAttrHandler)
    }
}

func phraseInterpret(_ phraseAttrHandler: @escaping PhraseAttributeHandlerFun) -> ((MusicContext, Music, PlayerMap, [PhraseAttribute]) -> Performance) {
    
    return { (context: MusicContext, music: Music, pm: PlayerMap, phraseAttrs: [PhraseAttribute]) in
        let (events, pcontexts) = music.musicToPerformance(context: context, playerMap: pm)
        let interprettedEvents = phraseAttrs.reduce(events, phraseAttrHandler)
        
        return (interprettedEvents, pcontexts)
    }
}

public let playerMapDefault = {(playerName: String) -> Player in
    switch playerName {
    case defaultPlayerName:
        return defaultPlayer
    case fancyPlayerName:
        return fancyPlayer
    default:
        return defaultPlayer
    }
}
