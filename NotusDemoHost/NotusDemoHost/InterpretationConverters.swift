import Foundation
import Notus

class InterpretationConverters {
    static func crescendo(music: Music) -> Music {
        let part1 = Control.player(fancyPlayerName) =>
            Control.interpret([PhraseAttribute.dynamic(.crescendo(2))]) =>
            music
        
        return part1
    }
    
    static func diminuendo(music: Music) -> Music {
        let part1 = Control.player(fancyPlayerName) =>
            Control.interpret([PhraseAttribute.dynamic(.diminuendo(2))]) =>
            music
        
        return part1
    }
    
    static func accelerando(music: Music) -> Music {
        let part1 = Control.player(fancyPlayerName) =>
            Control.interpret([PhraseAttribute.tempo(.accelerando)]) =>
            music
        
        return part1
    }
    
    static func ritardando(music: Music) -> Music {
        let part1 = Control.player(fancyPlayerName) =>
            Control.interpret([PhraseAttribute.tempo(.ritardando)]) =>
            music
        
        return part1
    }
    
    static func accent(music: Music) -> Music {
        let part1 = Control.player(fancyPlayerName) =>
            Control.interpret([PhraseAttribute.dynamic(.accent)]) =>
            music
        
        return part1
    }
    
    static func loudness(music: Music) -> Music {
        let part1 = Control.player(fancyPlayerName) =>
            Control.interpret([PhraseAttribute.dynamic(.loudness(.fff))]) =>
        music
        
        return part1
    }
    
    static func dynamicEvolutionPPPtoFFF(music: Music) -> Music {
        let part1 = Control.player(fancyPlayerName) =>
            Control.interpret([PhraseAttribute.dynamic(.dynamicEvolution(.ppp, .fff))]) =>
        music
        
        return part1
    }
    
    static func dynamicEvolutionFFFtoPPP(music: Music) -> Music {
        let part1 = Control.player(fancyPlayerName) =>
            Control.interpret([PhraseAttribute.dynamic(.dynamicEvolution(.fff, .ppp))]) =>
        music
        
        return part1
    }
    
    static func staccato(music: Music) -> Music {
        let part1 = Control.player(fancyPlayerName) =>
            Control.interpret([PhraseAttribute.articulation(.staccato)]) =>
        music
        
        return part1
    }
    
    static func legato(music: Music) -> Music {
        let part1 = Control.player(fancyPlayerName) =>
            Control.interpret([PhraseAttribute.articulation(.legato)]) =>
        music
        
        return part1
    }
    
    static func slurred(music: Music, upm: UserPatchMap) -> Music {
        let part1 = Control.player(fancyPlayerName) =>
            Control.interpret([PhraseAttribute.articulation(.slurred)]) =>
        music
        
        return part1
    }
}
