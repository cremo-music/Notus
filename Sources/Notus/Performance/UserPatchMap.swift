import Foundation

public struct UserPatchMap {
    public typealias UserPatch = (Staff, Channel, Instrument)
    
    private typealias StaffChannelMap = [Staff: Channel]
    private typealias ChannelInstrumentMap = [Channel: Instrument]    
    
    private var iterator: DictionaryIterator<Staff, Channel>?
    private var staffChannelMap = StaffChannelMap()
    private var channelInstrumentMap =  ChannelInstrumentMap()
    
    
    public init(_ userPathMapping: [UserPatch]) throws {
        try userPathMapping.forEach { (staff, channel, instrument) in
            if staffChannelMap[staff] != nil {
                throw NSError(domain: "UserPatchMap", code: -1, userInfo: [NSLocalizedDescriptionKey: "Duplicated staff: \(staff)"])
            }
            
            if channelInstrumentMap[channel] != nil && channelInstrumentMap[channel]! != instrument {
                throw NSError(domain: "UserPatchMap", code: -1,
                              userInfo: [NSLocalizedDescriptionKey: "Multiple instrument for channel inconsistency: channel \(channel)"])
            }
            
            staffChannelMap[staff] = channel
            channelInstrumentMap[channel] = instrument
        }
    }
}

extension UserPatchMap {
    public func isValid(music: Music) -> Bool {
        let staffFromMusic = UserPatchMap.extractStaff(music: music)
        
        let staffFromUPM = self.flatMap({ (up) -> Set<Staff> in
            return Set<Staff>([up.0])
        })
        
        return staffFromMusic.intersection(staffFromUPM) == staffFromMusic
    }
    
    // will create a user patch map with at least one user patch
    public static func makeGMMap(music: Music) -> UserPatchMap {
        let staffs = UserPatchMap.extractStaff(music: music)
        
        let userPatch = staffs.map { (staff) -> UserPatchMap.UserPatch in
            let channel: Channel = staff > 15 ? .ch15 : channels[Int(staff)]
            return (staff, channel, .acousticGrandPiano)
        }
        
        return try! UserPatchMap(userPatch.count == 0 ? [(0, .ch0, .acousticGrandPiano)] : userPatch)
    }

    static private func extractStaff(music: Music) -> Set<Staff> {
        switch music {
        case .modify(let .staff(newStaff), let music):
            return Set<Staff>([newStaff]).union(extractStaff(music: music))
        case .modify(_, let music):
            return extractStaff(music: music)
        case .prim(_):
            return Set<Staff>()
        case .seq(let music0, let music1):
            return extractStaff(music:music0).union(extractStaff(music:music1))
        case .stack(let music0, let music1):
            return extractStaff(music:music0).union(extractStaff(music:music1))
        }
    }
    
}

extension UserPatchMap: Sequence, IteratorProtocol {
    subscript(key: Staff) -> (Channel, Instrument)? {
        guard let ch = staffChannelMap[key] else {
            return nil
        }
        
        let inst = channelInstrumentMap[ch]!
        
        return (ch, inst)
    }
    
    public mutating func next() -> UserPatch? {
        
        if iterator == nil {
            iterator = staffChannelMap.makeIterator()
        }
        
        guard let elem = iterator?.next() else {
            iterator = nil
            return nil
        }
        
        return (elem.key, elem.value, channelInstrumentMap[elem.value]!)
    }
}
