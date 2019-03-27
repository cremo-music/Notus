import XCTest
@testable import Notus

class MusicNotationTests: XCTestCase {
    
    /// This is needed for testing on Linux
    static var allTests : [(String, (MusicNotationTests) -> () throws -> Void)] {
        return [
            ("testPrimitiveEquality", testPrimitiveEquality),
            ("testSeqEquality", testSeqEquality),
            ("testStackEquality", testStackEquality),
            ("testParanteses", testParanteses),
            ("testRepeated", testRepeated),
            ("testSimpleNotation", testSimpleNotation)
        ]
    }
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
        
    func testPrimitiveEquality() {
        let note: Music = .prim(.note(.qn, (.c, 4)))
        XCTAssert(note == note)
        
        let sameNote: Music = .prim(.note(.qn, (.c, 4)))
        XCTAssert(sameNote == note)
        
        let differentDuration: Music = .prim(.note(.en, (.c, 4)))
        XCTAssert(differentDuration != note)
        
        let differentPitch: Music = .prim(.note(.qn, (.d, 4)))
        XCTAssert(differentPitch != note)
    }
    
    func testSeqEquality() {
        let sequence: Music = .prim(.note(.qn, (.c, 4))) ++ .prim(.note(.qn, (.e, 4))) ++ .prim(.note(.qn, (.g, 4)))
        XCTAssert(sequence == sequence)
        
        let sameSequence: Music = .prim(.note(.qn, (.c, 4))) ++ .prim(.note(.qn, (.e, 4))) ++ .prim(.note(.qn, (.g, 4)))
        XCTAssert(sameSequence == sequence)
        
        let anotherSequence: Music = .prim(.note(.qn, (.d, 4))) ++ .prim(.note(.qn, (.f, 4))) ++ .prim(.note(.qn, (.a, 4)))
        XCTAssert(anotherSequence != sequence)
    }
    
    func testStackEquality() {
        let stack: Music = .prim(.note(.qn, (.c, 4))) |=| .prim(.note(.qn, (.e, 4))) |=| .prim(.note(.qn, (.g, 4)))
        XCTAssert(stack == stack)
        
        let sameStack: Music = .prim(.note(.qn, (.c, 4))) |=| .prim(.note(.qn, (.e, 4))) |=| .prim(.note(.qn, (.g, 4)))
        XCTAssert(sameStack == stack)
        
        let anotherStack: Music = .prim(.note(.qn, (.d, 4))) |=| .prim(.note(.qn, (.f, 4))) |=| .prim(.note(.qn, (.a, 4)))
        XCTAssert(anotherStack != stack)
    }
    
    func testParanteses() {
        let sequence: Music = .prim(.note(.qn, (.c, 4))) ++ .prim(.note(.qn, (.e, 4))) ++ .prim(.note(.qn, (.g, 4))) ++ .prim(.note(.qn, (.c, 4)))
        
        let grouping31: Music = (.prim(.note(.qn, (.c, 4))) ++ .prim(.note(.qn, (.e, 4))) ++ .prim(.note(.qn, (.g, 4)))) ++ .prim(.note(.qn, (.c, 4)))
        
        let grouping13: Music = .prim(.note(.qn, (.c, 4))) ++ (.prim(.note(.qn, (.e, 4))) ++ .prim(.note(.qn, (.g, 4))) ++ .prim(.note(.qn, (.c, 4))))
        
        let grouping22: Music = (.prim(.note(.qn, (.c, 4))) ++ .prim(.note(.qn, (.e, 4)))) ++ (.prim(.note(.qn, (.g, 4))) ++ .prim(.note(.qn, (.c, 4))))
        
        XCTAssert(sequence == grouping31)
        XCTAssert(sequence != grouping13)
        XCTAssert(sequence != grouping22)
    }
    
    
    func testRepeated() {
        let music: Music = .prim(.note(.qn, (.c, 4))) ++ .prim(.note(.qn, (.e, 4))) ++ .prim(.note(.qn, (.g, 4)))
        let musicRepeated = music.repeated()
        let expectedRepeated: Music = (.prim(.note(.qn, (.c, 4))) ++ .prim(.note(.qn, (.e, 4))) ++ .prim(.note(.qn, (.g, 4)))) ++
                                      (.prim(.note(.qn, (.c, 4))) ++ .prim(.note(.qn, (.e, 4))) ++ .prim(.note(.qn, (.g, 4))))
        
        XCTAssert(expectedRepeated == musicRepeated)
        
        let musicRepeatedTwice = music.repeated(2)
        let expectedRepeatedTwice: Music = (.prim(.note(.qn, (.c, 4))) ++ .prim(.note(.qn, (.e, 4))) ++ .prim(.note(.qn, (.g, 4)))) ++
                                           ((.prim(.note(.qn, (.c, 4))) ++ .prim(.note(.qn, (.e, 4))) ++ .prim(.note(.qn, (.g, 4)))) ++
                                           (.prim(.note(.qn, (.c, 4))) ++ .prim(.note(.qn, (.e, 4))) ++ .prim(.note(.qn, (.g, 4)))))
        XCTAssert(expectedRepeatedTwice == musicRepeatedTwice)
    }
    
    func testSimpleNotation() {
        let musicPrim: Music = .prim(.note(.qn, (.c, 4))) ++ .prim(.note(.qn, (.e, 4))) ++ .prim(.note(.qn, (.g, 4)))
        let musicNote: Music = O(.qn, (.c, 4)) ++ O(.qn, (.e, 4)) ++ O(.qn, (.g, 4))
        XCTAssert(musicPrim == musicNote)
        
        let restsNote = R(.qn) ++ R(.qn)
        let restsPrim: Music = .prim(.rest(.qn)) ++ .prim(.rest(.qn))
        XCTAssert(restsPrim == restsNote)
    }

}


