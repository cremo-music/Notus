import XCTest
@testable import Notus

class DefaultPlayerTests: XCTestCase {

    let sequence: Music = O(.qn, (.c, 4)) ++ O(.qn, (.e, 4))
    let stack: Music = O(.qn, (.c, 4)) |=| O(.qn, (.e, 4))
    
    let defaultVol : Double = 64
    let qnLen = Dur.qn.toNotusDuration()
    let gQn: Music = O(.qn, (.g, 4))
    
    /// This is needed for testing on Linux
    static var allTests : [(String, (DefaultPlayerTests) -> () throws -> Void)] {
        return [
            ("testAccent", testAccent),
            ("testStaccato", testStaccato),
            ("testLegato", testLegato)
        ]
    }
    
    func testAccent() {
        // perform
        let seq0 =
            .player(defaultPlayerName) =>
            (.interpret([.dynamic(.accent)]) => sequence) ++
            gQn
        
        let stack0 =
            .player(defaultPlayerName) =>
            (.interpret([.dynamic(.accent)]) => stack) |=|
            gQn
        
        let (seqEvents, _) = seq0.perform(playerMap: playerMapDefault, userPatchMap: nil)
        let (stackEvents, _) = stack0.perform(playerMap: playerMapDefault, userPatchMap: nil)
        
        // assert
        XCTAssertEqual(seqEvents[0].vol, UInt8(defaultVol * 1.5))
        XCTAssertEqual(seqEvents[1].vol, UInt8(defaultVol * 1.5))
        XCTAssertEqual(seqEvents[2].vol, UInt8(defaultVol))
        
        XCTAssertEqual(stackEvents[0].vol, UInt8(defaultVol * 1.5))
        XCTAssertEqual(stackEvents[1].vol, UInt8(defaultVol * 1.5))
        XCTAssertEqual(stackEvents[2].vol, UInt8(defaultVol))
    }
    
    func testStaccato() {
        // perform
        let seq0 =
            .player(defaultPlayerName) =>
            (.interpret([.articulation(.staccato)]) => sequence) ++
            gQn
        
        let stack0 =
            .player(defaultPlayerName) =>
            (.interpret([.articulation(.staccato)]) => stack) |=|
            gQn
        
        let (seqEvents, _) = seq0.perform(playerMap: playerMapDefault, userPatchMap: nil)
        let (stackEvents, _) = stack0.perform(playerMap: playerMapDefault, userPatchMap: nil)
        
        // assert
        let staccatoFrac: DurT = 0.5
        
        XCTAssertEqual(seqEvents[0].time, 0)
        XCTAssertEqual(seqEvents[0].dur, qnLen * staccatoFrac)
        XCTAssertEqual(seqEvents[1].time, Time(1 * qnLen))
        XCTAssertEqual(seqEvents[1].dur, qnLen * staccatoFrac)
        XCTAssertEqual(seqEvents[2].time, Time(2 * qnLen))
        XCTAssertEqual(seqEvents[2].dur, qnLen)
        
        XCTAssertEqual(stackEvents[0].time, 0)
        XCTAssertEqual(stackEvents[0].dur, qnLen * staccatoFrac)
        XCTAssertEqual(stackEvents[1].time, 0)
        XCTAssertEqual(stackEvents[1].dur, qnLen * staccatoFrac)
        XCTAssertEqual(stackEvents[2].time, 0)
        XCTAssertEqual(stackEvents[2].dur, qnLen)
    }
    
    func testLegato() {
        // perform
        let seq0 =
            .player(defaultPlayerName) =>
            (.interpret([PhraseAttribute.articulation(.legato)]) => sequence) ++
            gQn
        
        let stack0 =
            .player(defaultPlayerName) =>
            (.interpret([PhraseAttribute.articulation(.legato)]) => stack) |=|
            gQn
        
        let (seqEvents, _) = seq0.perform(playerMap: playerMapDefault, userPatchMap: nil)
        let (stackEvents, _) = stack0.perform(playerMap: playerMapDefault, userPatchMap: nil)
        
        // assert
        let legatoFrac: DurT = 1.2
        
        XCTAssertEqual(seqEvents[0].time, 0)
        XCTAssertEqual(seqEvents[0].dur, qnLen * legatoFrac)
        XCTAssertEqual(seqEvents[1].time, Time(1 * qnLen))
        XCTAssertEqual(seqEvents[1].dur, qnLen * legatoFrac)
        XCTAssertEqual(seqEvents[2].time, Time(2 * qnLen))
        XCTAssertEqual(seqEvents[2].dur, qnLen)
        
        XCTAssertEqual(stackEvents[0].time, 0)
        XCTAssertEqual(stackEvents[0].dur, qnLen * legatoFrac)
        XCTAssertEqual(stackEvents[1].time, 0)
        XCTAssertEqual(stackEvents[1].dur, qnLen * legatoFrac)
        XCTAssertEqual(stackEvents[2].time, 0)
        XCTAssertEqual(stackEvents[2].dur, qnLen)
    }

}
