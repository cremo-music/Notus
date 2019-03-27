import Foundation

public typealias DurT = Float64

extension Dur {
    
    func toNotusDuration() -> DurT {
        switch self {
        case .wn:     // whole note
            return 4.0
        case .hn:     // half note
            return 4.0 / 2.0
        case .qn:     // quarter note
            return 4.0 / 4.0
        case .en:     // eighth note
            return 4.0 / 8.0
        case .sn:     // sixteenth note
            return 4.0 / 16.0
        case .tn:     // thirty-second note
            return 4.0 / 32.0
            
        case .dwn:     // dotted whole note
            return 1.5 * Dur.wn.toNotusDuration()
        case .dhn:     // dotted half note
            return 1.5 * Dur.hn.toNotusDuration()
        case .dqn:     // dotted quarter note
            return 1.5 * Dur.qn.toNotusDuration()
        case .den:     // dotted eighth note
            return 1.5 * Dur.en.toNotusDuration()
        case .dsn:     // dotted sixteenth note
            return 1.5 * Dur.sn.toNotusDuration()
        case .dtn:     // dotted thirty-second note
            return 1.5 * Dur.tn.toNotusDuration()
            
        case .ddwn:     // dotted whole note
            return 1.75 * Dur.wn.toNotusDuration()
        case .ddhn:     // dotted half note
            return 1.75 * Dur.hn.toNotusDuration()
        case .ddqn:     // dotted quarter note
            return 1.75 * Dur.qn.toNotusDuration()
        case .dden:     // dotted eighth note
            return 1.75 * Dur.en.toNotusDuration()
        case .ddsn:     // dotted sixteenth note
            return 1.75 * Dur.sn.toNotusDuration()
        case .ddtn:     // dotted thirty-second note
            return 1.75 * Dur.tn.toNotusDuration()
            
        case .twn:     // triple whole note
            return 2.0 / 3.0 * Dur.wn.toNotusDuration()
        case .thn:     // triple half note
            return 2.0 / 3.0 * Dur.hn.toNotusDuration()
        case .tqn:     // dotted quarter note
            return 2.0 / 3.0 * Dur.qn.toNotusDuration()
        case .ten:     // dotted eighth note
            return 2.0 / 3.0 * Dur.en.toNotusDuration()
        case .tsn:     // dotted sixteenth note
            return 2.0 / 3.0 * Dur.sn.toNotusDuration()
        case .ttn:     // dotted thirty-second note
            return 2.0 / 3.0 * Dur.tn.toNotusDuration()
            
        }
    }
    
    ///
    /// Find the Notus duration that matches the actual duration best
    ///
    public static func toNotusDurations(_ dur: DurT) -> [Dur] {
        var acc = [Dur]()
        return toNotusDurations(dur, acc: &acc)
    }
    
    private static func toNotusDurations(_ dur: DurT, acc: inout [Dur]) -> [Dur] {
        let smallestPossibleDur = Dur.allCases.map { $0.toNotusDuration() }.min()!
        
        let largestDur = findLargestDurSmallerThan(dur)
        let smallestDur = findSmallestDurLargerThan(dur)
        if let largestDur = largestDur, let smallestDur = smallestDur {
            return calcDuration(dur: dur, closestLarger: largestDur, closestSmaller: smallestDur, acc: &acc)
        }
        
        if let largestDur = largestDur {
            return calcDuration(dur: dur, closestLarger: largestDur, acc: &acc)
        }
        
        if let smallestDur = smallestDur {
            if dur > smallestPossibleDur / 2.0 {
                acc.append(smallestDur)
            }
            return acc
        }
        
        return acc
    }
    
    private static func calcDuration(dur: DurT, closestLarger largestDur: Dur, closestSmaller smallestDur: Dur, acc: inout [Dur])  -> [Dur] {
        let absLargestDuration = largestDur.toNotusDuration()
        let absSmallestDuration = smallestDur.toNotusDuration()
        let diffLargest = dur - absLargestDuration
        let diffSmallest = absSmallestDuration - dur
        
        if abs(absLargestDuration - dur) < 0.0001 {
            acc.append(largestDur)
            return acc
        }
        
        if abs(absSmallestDuration - dur) < 0.0001 {
            acc.append(smallestDur)
            return acc
        }
        
        if isDivisible(diffLargest) {
            acc.append(largestDur)
            return toNotusDurations(diffLargest, acc: &acc)
        }
        
        if (diffLargest < diffSmallest) {
            acc.append(largestDur)
        } else {
            acc.append(smallestDur)
        }
        
        return acc
    }
    
    private static func calcDuration(dur: DurT, closestLarger largestDur: Dur, acc: inout [Dur]) -> [Dur] {
        let absLargestDuration = largestDur.toNotusDuration()
        let diffLargest = dur - absLargestDuration
        acc.append(largestDur)
        
        return toNotusDurations(diffLargest, acc: &acc)
    }
    
    private static func findLargestDurSmallerThan(_ dur: DurT) -> Dur? {
        let allDurations = Dur.allCases.map { ($0, $0.toNotusDuration()) }.sorted { $0.1 > $1.1}
        let largestSmallerThan = allDurations.first(where: { $0.1 <= dur })
        return largestSmallerThan?.0
    }
    
    private static func findSmallestDurLargerThan(_ dur: DurT) -> Dur? {
        let allDurations = Dur.allCases.map { ($0, $0.toNotusDuration()) }.sorted { $0.1 < $1.1}
        let smallestLargerThan = allDurations.first(where: { $0.1 > dur })
        return smallestLargerThan?.0
    }
    
    
    private static func isDivisible(_ dur: DurT) -> Bool {
        let smallestPossibleDur = Dur.allCases.map { $0.toNotusDuration() }.min()!
        return dur >= smallestPossibleDur
    }
}

extension Music {
    public func duration(cut: Bool = false) -> DurT {
        switch self {
        case .modify(_, let music):
            return music.duration()
        case .stack(let (musicUpper, musicLower)):
            let upperDuration = musicUpper.duration()
            let lowerDuration = musicLower.duration()
            return cut ? min(upperDuration, lowerDuration) : max(upperDuration, lowerDuration)
        case .seq(let (musicLeft, musicRight)):
            return musicLeft.duration() + musicRight.duration()
        case .prim(let .note(dur, _)):
            return dur.toNotusDuration()
        case .prim(let .noteAttr(dur, _, _)):
            return dur.toNotusDuration()
        case .prim(let .rest(dur)):
            return dur.toNotusDuration()
        case .prim(.none):
            return 0
        }
    }
}
