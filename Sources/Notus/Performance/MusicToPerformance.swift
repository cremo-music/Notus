import Foundation

extension Music {
    public func perform(playerMap: PlayerMap, userPatchMap: UserPatchMap?) -> Performance {
        
        let userPatchMap = userPatchMap != nil && userPatchMap!.isValid(music: self) ? userPatchMap! : UserPatchMap.makeGMMap(music: self)
        let mContext = MusicContext(player: playerMap(defaultPlayerName), vol: 64, beat: 0, transpose: 0, staff: 0, userPatchMap: userPatchMap)
        
        return musicToPerformance(context: mContext, playerMap: playerMap)
    }
    
    public func musicToPerformance(context: MusicContext, playerMap: PlayerMap) -> Performance {
        switch self {
        case .modify(let .tempo(bpm), let music):
            let per = music.musicToPerformance(context: context, playerMap: playerMap)
            return (per.0, per.1 + [PerformanceContext(tempo: bpm, time: context.beat)])
            
        case .modify(let .transpose(abspitch), let music):
            var updatedContext = context
            updatedContext.transpose += abspitch
            return music.musicToPerformance(context: updatedContext, playerMap: playerMap)
            
        case .modify(let .staff(newStaff), let music):
            var updatedContext = context
            updatedContext.staff = newStaff
            return music.musicToPerformance(context: updatedContext, playerMap: playerMap)
            
        case .modify(let .player(playerName), let music):
            var updatedContext = context
            updatedContext.player = playerMap(playerName)
            return music.musicToPerformance(context: updatedContext, playerMap: playerMap)
            
        case .modify(let .interpret(attrs), let music):
            return context.player.phraseInterpret(context, music, playerMap, attrs)
            
        case .modify(let .volume(vol), let music):
            var updatedContext = context
            updatedContext.vol = vol
            return music.musicToPerformance(context: updatedContext, playerMap: playerMap)
            
        case .stack(let (musicUpper, musicLower)):
            let per0 = musicUpper.musicToPerformance(context: context, playerMap: playerMap)
            let per1 = musicLower.musicToPerformance(context: context, playerMap: playerMap)
            return (per0.0 + per1.0, per0.1 + per1.1)
            
        case .seq(let (musicLeft, musicRight)):
            var updatedContext = context
            updatedContext.beat += Time(musicLeft.duration())
            let per0 = musicLeft.musicToPerformance(context: context, playerMap: playerMap)
            let per1 = musicRight.musicToPerformance(context: updatedContext, playerMap: playerMap)
            return (per0.0 + per1.0, per0.1 + per1.1)
            
        case .prim(let prim):
            return primToPerformance(context: context, prim:prim)
        }
    }

    
    private func primToPerformance(context: MusicContext, prim: Primitive) -> Performance {
        switch prim {
        case .note(let (dur, pitch)):
            let event = context.player.noteInterpret(context, pitch, dur, [])
            return ([event], [])
        case .noteAttr(let (dur, pitch, attrs)):
            let event = context.player.noteInterpret(context, pitch, dur, attrs)
            return ([event], [])
        case .rest(let dur):
            // set volume to 0
            // note: we cannot ignore the rest if it occurs as the last part in the music part
            // (in case we stitch it with another part, we need the last rest as well)
            let (ch, _) = context.userPatchMap[context.staff]!
            let event: Event = Event(pitch: 0, ch: ch, instr: Instrument.acousticGrandPiano,
                                     vol: 0, time: context.absTime + context.beat, dur: dur.toNotusDuration())
            return ([event], [])
        case .none:
            return ([], [])
        }
    }
}

