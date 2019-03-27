import XCTest
@testable import Notus

class UserPatchMapTests: XCTestCase {

    /// This is needed for testing on Linux
    static var allTests : [(String, (UserPatchMapTests) -> () throws -> Void)] {
        return [
            ("testInitUserPatchMap_with_valid_patch", testInitUserPatchMap_with_valid_patch),
            ("testInitUserPatchMap_with_invalid_patch1", testInitUserPatchMap_with_invalid_patch1),
            ("testInitUserPatchMap_with_invalid_patch2", testInitUserPatchMap_with_invalid_patch2),
            ("testInitUserPatchMap_with_invalid_patch3", testInitUserPatchMap_with_invalid_patch3),
            ("testInitUserPatchMap_with_invalid_patch4", testInitUserPatchMap_with_invalid_patch4),
            ("testUserPatchMap_with_matching_music", testUserPatchMap_with_matching_music),
            ("testUserPatchMap_with_nonmatching_music1", testUserPatchMap_with_nonmatching_music1),
            ("testUserPatchMap_generate_gpm_for_music", testUserPatchMap_generate_gpm_for_music)
        ]
    }
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitUserPatchMap_with_valid_patch() {
        let userPatch: [UserPatchMap.UserPatch] = [(0, .ch0, .timpani),
                                                   (1, .ch1, .cello)]
        
        XCTAssertNoThrow(try UserPatchMap(userPatch), "should not throw")
    }
    
    func testInitUserPatchMap_with_invalid_patch1() {
        let userPatch: [UserPatchMap.UserPatch] = [(0, .ch0, .timpani),
                                                   (1, .ch0, .cello)]
        
        XCTAssertThrowsError(try UserPatchMap(userPatch), "should throw")
    }
    
    func testInitUserPatchMap_with_invalid_patch2() {
        let userPatch: [UserPatchMap.UserPatch] = [(0, .ch0, .timpani),
                                                   (0, .ch1, .cello)]
        
        XCTAssertThrowsError(try UserPatchMap(userPatch), "should throw")
    }
    
    func testInitUserPatchMap_with_invalid_patch3() {
        let userPatch: [UserPatchMap.UserPatch] = [(0, .ch0, .timpani),
                                                   (0, .ch0, .timpani)]
        
        XCTAssertThrowsError(try UserPatchMap(userPatch), "should throw")
    }
    
    func testInitUserPatchMap_with_invalid_patch4() {
        let userPatch: [UserPatchMap.UserPatch] = [(0, .ch0, .timpani),
                                                   (0, .ch0, .cello)]
        
        XCTAssertThrowsError(try UserPatchMap(userPatch), "should throw")
    }
    
    func testUserPatchMap_with_matching_music() {
        let userPatch: [UserPatchMap.UserPatch] = [(0, .ch0, .timpani),
                                                   (1, .ch1, .cello)]
        
        guard let upm = try? UserPatchMap(userPatch) else {
            XCTAssert(false)
            return
        }
        
        XCTAssertTrue(upm.isValid(music: music()))
    }
    
    func testUserPatchMap_with_nonmatching_music1() {
        let userPatch: [UserPatchMap.UserPatch] = [(0, .ch0, .timpani),
                                                   (2, .ch1, .cello)]
        
        guard let upm = try? UserPatchMap(userPatch) else {
            XCTAssert(false)
            return
        }
        
        XCTAssertFalse(upm.isValid(music: music()))
    }
    
    func testUserPatchMap_generate_gpm_for_music() {
        let upm = UserPatchMap.makeGMMap(music: music())
        
        XCTAssertTrue(upm.isValid(music: music()))
    }
    
    private func music() -> Music {
        let bassPart: Music = .prim(.note(.qn, (.d, 2))) ++ .prim(.note(.qn, (.a, 1))) ++
            .prim(.note(.qn, (.d, 2))) ++ .prim(.note(.qn, (.a, 1)))
        
        let melOct: Octave = 3
        let melody1: Music = .prim(.note(.qn, (.d, melOct))) ++ .prim(.note(.qn, (.e, melOct))) ++
            .prim(.note(.en, (.f, melOct))) ++ .prim(.note(.en, (.e, melOct))) ++ .prim(.note(.qn, (.d, melOct)))
        
        let melody2: Music = .prim(.note(.qn, (.f, melOct))) ++ .prim(.note(.qn, (.g, melOct))) ++ .prim(.note(.hn, (.a, melOct)))
        
        let melody3: Music = .prim(.note(.den, (.a, melOct))) ++ .prim(.note(.sn, (.bf, melOct))) ++
            .prim(.note(.en, (.a, melOct))) ++ .prim(.note(.en, (.g, melOct))) ++
            .prim(.note(.en, (.f, melOct))) ++ .prim(.note(.en, (.e, melOct))) ++ .prim(.note(.qn, (.d, melOct)))
        
        let staff0Part = .staff(0) => bassPart.repeated(7)
        let staff1Part = .staff(1) =>
            .prim(.rest(.wn)) ++ .prim(.rest(.wn)) ++
            melody1.repeated() ++
            melody2.repeated() ++
            melody3.repeated()
        
        return .tempo(60) => staff0Part |=| staff1Part
    }
}

/// This extension is needed for testing on Linux

