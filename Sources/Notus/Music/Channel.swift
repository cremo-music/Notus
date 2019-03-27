import Foundation

let channels: [Channel] = [
    .ch0, .ch1, .ch2, .ch3, .ch4, .ch5, .ch6, .ch7, .ch8, .ch9,.ch10,.ch11,.ch12,.ch13,.ch14,.ch15
]

public enum Channel: UInt8 {
    case ch0 = 0
    case ch1 = 1
    case ch2 = 2
    case ch3 = 3
    case ch4 = 4
    case ch5 = 5
    case ch6 = 6
    case ch7 = 7
    case ch8 = 8
    case ch9 = 9
    case ch10 = 10
    case ch11 = 11
    case ch12 = 12
    case ch13 = 13
    case ch14 = 14
    case ch15 = 15
}

public func channelFromRawValue(_ ch: UInt8) -> Channel? {

    switch ch {
    case 0: return .ch0
    case 1: return .ch1
    case 2: return .ch2
    case 3: return .ch3
    case 4: return .ch4
    case 5: return .ch5
    case 6: return .ch6
    case 7: return .ch7
    case 8: return .ch8
    case 9: return .ch9
    case 10: return .ch10
    case 11: return .ch11
    case 12: return .ch12
    case 13: return .ch13
    case 14: return .ch14
    case 15: return .ch15
    case _ : return nil
    }
    
}
