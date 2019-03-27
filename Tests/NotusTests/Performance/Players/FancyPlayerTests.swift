import XCTest
@testable import Notus

class FancyPlayerTests: XCTestCase {
    let sequence: Music = O(.qn, (.c, 4)) ++ O(.qn, (.e, 4)) ++ O(.qn, (.g, 4))
    let stack: Music = O(.qn, (.c, 4)) |=| O(.qn, (.e, 4)) |=| O(.qn, (.g, 4))
    
    let defaultVol : Float = 64
    let qnLen = Dur.qn.toNotusDuration()
    
    /// This is needed for testing on Linux
    static var allTests : [(String, (FancyPlayerTests) -> () throws -> Void)] {
        return [
            ("testLoudness", testLoudness),
            ("testDynamicEvolution", testDynamicEvolution),
            ("testCrescendo", testCrescendo),
            ("testDiminuendo", testDiminuendo),
            ("testRitardando", testRitardando),
            ("testAccelerando", testAccelerando),
            ("testSlurred", testSlurred)
        ]
    }
    
    func testLoudness() {
        // perform
        let seqMod = .player(fancyPlayerName) => (.interpret([.dynamic(.loudness(.fff))]) => sequence)
        let stackMod = .player(fancyPlayerName) => (.interpret([.dynamic(.loudness(.ppp))]) => stack)
        
        let (seqEvents, _) = seqMod.perform(playerMap: playerMapDefault, userPatchMap: nil)
        let (stackEvents, _) = stackMod.perform(playerMap: playerMapDefault, userPatchMap: nil)
        
        // assert
        XCTAssertEqual(seqEvents[0].vol, Loudness.fff.toVol())
        XCTAssertEqual(seqEvents[1].vol, Loudness.fff.toVol())
        XCTAssertEqual(seqEvents[2].vol, Loudness.fff.toVol())
        
        XCTAssertEqual(stackEvents[0].vol, Loudness.ppp.toVol())
        XCTAssertEqual(stackEvents[1].vol, Loudness.ppp.toVol())
        XCTAssertEqual(stackEvents[2].vol, Loudness.ppp.toVol())
    }
    
    func testDynamicEvolution() {
        // perform
        let seqMod0 = .player(fancyPlayerName) => .interpret([.dynamic(.dynamicEvolution(.pp, .ff))]) => sequence
        let (seqEventsPPFF, _) = seqMod0.perform(playerMap: playerMapDefault, userPatchMap: nil)
        
        let seqMod1 = .player(fancyPlayerName) => .interpret([.dynamic(.dynamicEvolution(.nf, .p))]) => sequence
        let (seqEventsNFP, _) = seqMod1.perform(playerMap: playerMapDefault, userPatchMap: nil)
        
        let seqMod2 = .player(fancyPlayerName) => .interpret([.dynamic(.dynamicEvolution(.mf, .mp))]) => sequence
        let (seqEventsMFMP, _) = seqMod2.perform(playerMap: playerMapDefault, userPatchMap: nil)
        
        let stack0 = .player(fancyPlayerName) => .interpret([.dynamic(.dynamicEvolution(.sf, .nf))]) => stack
        let (stackEvents, _) = stack0.perform(playerMap: playerMapDefault, userPatchMap: nil)

        // assert
        XCTAssertEqual(seqEventsPPFF[0].vol, Loudness.pp.toVol())
        var midVol = round(Float(Loudness.pp.toVol() + Loudness.ff.toVol())/2.0)
        XCTAssertEqual(seqEventsPPFF[1].vol, UInt8(midVol))
        XCTAssertEqual(seqEventsPPFF[2].vol, Loudness.ff.toVol())
        
        XCTAssertEqual(seqEventsNFP[0].vol, Loudness.nf.toVol())
        midVol = round(Float(Loudness.nf.toVol() + Loudness.p.toVol())/2.0)
        XCTAssertEqual(seqEventsNFP[1].vol, UInt8(midVol))
        XCTAssertEqual(seqEventsNFP[2].vol, Loudness.p.toVol())
        
        XCTAssertEqual(seqEventsMFMP[0].vol, Loudness.mf.toVol())
        midVol = round(Float(Loudness.mf.toVol() + Loudness.mp.toVol())/2.0)
        XCTAssertEqual(seqEventsMFMP[1].vol, UInt8(midVol))
        XCTAssertEqual(seqEventsMFMP[2].vol, Loudness.mp.toVol())
        
        XCTAssertEqual(stackEvents[0].vol, Loudness.sf.toVol())
        XCTAssertEqual(stackEvents[1].vol, Loudness.sf.toVol())
        XCTAssertEqual(stackEvents[2].vol, Loudness.sf.toVol())
    }
    
    func testCrescendo() {
        let factor: Float = 1.5
        // perform
        let seq0 = .player(fancyPlayerName) => .interpret([.dynamic(.crescendo(factor))]) => sequence
        let (seqEvents, _) = seq0.perform(playerMap: playerMapDefault, userPatchMap: nil)
        
        let stack0 = .player(fancyPlayerName) => .interpret([.dynamic(.crescendo(factor))]) => stack
        let (stackEvents, _) = stack0.perform(playerMap: playerMapDefault, userPatchMap: nil)
        
        // assert
        let middleVolume = round(defaultVol + (defaultVol * factor - defaultVol)/2)
        let endVolume = round(defaultVol * factor)
        
        XCTAssertEqual(seqEvents[0].vol, UInt8(defaultVol))
        XCTAssertEqual(seqEvents[1].vol, UInt8(middleVolume))
        XCTAssertEqual(seqEvents[2].vol, UInt8(endVolume))
        
        XCTAssertEqual(stackEvents[0].vol, UInt8(defaultVol))
        XCTAssertEqual(stackEvents[1].vol, UInt8(defaultVol))
        XCTAssertEqual(stackEvents[2].vol, UInt8(defaultVol))
    }
    
    func testDiminuendo() {
        let factor: Float = 2
        // perform
        let seq0 = .player(fancyPlayerName) => .interpret([.dynamic(.diminuendo(factor))]) => sequence
        let (seqEvents, _) = seq0.perform(playerMap: playerMapDefault, userPatchMap: nil)
        
        let stack0 = .player(fancyPlayerName) => .interpret([.dynamic(.diminuendo(factor))]) => stack
        let (stackEvents, _) = stack0.perform(playerMap: playerMapDefault, userPatchMap: nil)
        
        // assert
        let middleVolume = round(defaultVol + (defaultVol * 1/factor - defaultVol)/2)
        let endVolume = round(defaultVol * 1/factor)
        
        XCTAssertEqual(seqEvents[0].vol, UInt8(defaultVol))
        XCTAssertEqual(seqEvents[1].vol, UInt8(middleVolume))
        XCTAssertEqual(seqEvents[2].vol, UInt8(endVolume))
        
        XCTAssertEqual(stackEvents[0].vol, UInt8(defaultVol))
        XCTAssertEqual(stackEvents[1].vol, UInt8(defaultVol))
        XCTAssertEqual(stackEvents[2].vol, UInt8(defaultVol))
    }
    
    func testRitardando() {
        // perform
        let seqOrig = .player(fancyPlayerName) => sequence
        let seqRit = .player(fancyPlayerName) => .interpret([.tempo(.ritardando)]) => sequence
        let (seqOrigEvents, _) = seqOrig.perform(playerMap: playerMapDefault, userPatchMap: nil)
        let (seqEvents, _) = seqRit.perform(playerMap: playerMapDefault, userPatchMap: nil)

        let stackOrig = .player(fancyPlayerName) => stack
        let stackRit = .player(fancyPlayerName) => .interpret([.tempo(.ritardando)]) => stack
        let (stackOrigEvents, _) = stackOrig.perform(playerMap: playerMapDefault, userPatchMap: nil)
        let (stackRitEvents, _) = stackRit.perform(playerMap: playerMapDefault, userPatchMap: nil)
        
        // assert
        let stretchFactor: Double = 0.2
        
        var dur = seqOrigEvents.dur(includeDurationOnLastEvent: true)
        let stepFactor = stretchFactor / dur
        
        let middleTime = (1 + qnLen * stepFactor) * qnLen
        var endTime = dur + (dur * stretchFactor)
        
        XCTAssertEqual(seqEvents[0].time, 0)
        XCTAssert(seqEvents[1].time - middleTime < .ulpOfOne)
        XCTAssert(seqEvents[2].time + seqEvents[2].dur - endTime < .ulpOfOne)
        
        dur = stackOrigEvents.dur(includeDurationOnLastEvent: true)
        endTime = dur + (dur * stretchFactor)
        
        XCTAssertEqual(stackRitEvents[0].time, 0)
        XCTAssertEqual(stackRitEvents[0].dur, endTime)
        XCTAssertEqual(stackRitEvents[1].time, 0)
        XCTAssertEqual(stackRitEvents[0].dur, endTime)
        XCTAssertEqual(stackRitEvents[2].time, 0)
        XCTAssertEqual(stackRitEvents[0].dur, endTime)
    }
    
    func testAccelerando() {
        // perform
        let seqOrig = .player(fancyPlayerName) => sequence
        let seqAcc = .player(fancyPlayerName) => .interpret([.tempo(.accelerando)]) => sequence
        let (seqOrigEvents, _) = seqOrig.perform(playerMap: playerMapDefault, userPatchMap: nil)
        let (seqAccEvents, _) = seqAcc.perform(playerMap: playerMapDefault, userPatchMap: nil)
        
        let stackOrig = .player(fancyPlayerName) => stack
        let stackAcc = .player(fancyPlayerName) => .interpret([.tempo(.accelerando)]) => stack
        let (stackOrigEvents, _) = stackOrig.perform(playerMap: playerMapDefault, userPatchMap: nil)
        let (stackAccEvents, _) = stackAcc.perform(playerMap: playerMapDefault, userPatchMap: nil)
        
        // assert
        let stretchFactor: Double = -0.2
        
        var dur = seqOrigEvents.dur(includeDurationOnLastEvent: true)
        let stepFactor = stretchFactor / dur
        
        let middleTime = (1 + qnLen * stepFactor) * qnLen
        var endTime = dur - (dur * stretchFactor)
        
        XCTAssertEqual(seqAccEvents[0].time, 0)
        XCTAssert(seqAccEvents[1].time - middleTime < .ulpOfOne)
        XCTAssert(seqAccEvents[2].time + seqAccEvents[2].dur - endTime < .ulpOfOne)
        
        dur = stackOrigEvents.dur(includeDurationOnLastEvent: true)
        endTime = dur + (dur * stretchFactor)
        
        XCTAssertEqual(stackAccEvents[0].time, 0)
        XCTAssertEqual(stackAccEvents[0].dur, endTime)
        XCTAssertEqual(stackAccEvents[1].time, 0)
        XCTAssertEqual(stackAccEvents[0].dur, endTime)
        XCTAssertEqual(stackAccEvents[2].time, 0)
        XCTAssertEqual(stackAccEvents[0].dur, endTime)
    }
    
    func testSlurred() {
        // perform
        let seq0 = .player(fancyPlayerName) => .interpret([.articulation(.slurred)]) => sequence
        let (seqEvents, _) = seq0.perform(playerMap: playerMapDefault, userPatchMap: nil)
        
        let stack0 = .player(fancyPlayerName) => .interpret([.articulation(.slurred)]) => stack
        let (stackEvents, _) = stack0.perform(playerMap: playerMapDefault, userPatchMap: nil)
        
        // assert
        let factor: DurT = 1.2
        
        XCTAssertEqual(seqEvents[0].dur, qnLen * factor)
        XCTAssertEqual(seqEvents[1].dur, qnLen * factor)
        XCTAssertEqual(seqEvents[2].dur, qnLen)
        
        XCTAssertEqual(stackEvents[0].dur, qnLen)
        XCTAssertEqual(stackEvents[1].dur, qnLen)
        XCTAssertEqual(stackEvents[2].dur, qnLen)
    }
}

