//
//  SuffixOccurrence.swift
//  SuffixSequence
//
//  Created by Андрей Парчуков on 18.08.2022.
//


struct SuffixOccurrence: Comparable, Codable {
    
    let suffix: String
    let occurrenceCount: Int
    
    static func <(lhs: SuffixOccurrence, rhs: SuffixOccurrence) -> Bool {
        if lhs.occurrenceCount == rhs.occurrenceCount {
            return lhs.suffix > rhs.suffix
        } else {
            return lhs.occurrenceCount < rhs.occurrenceCount
        }
    }
    
    static func >(lhs: SuffixOccurrence, rhs: SuffixOccurrence) -> Bool {
        if lhs.occurrenceCount == rhs.occurrenceCount {
            return lhs.suffix < rhs.suffix
        } else {
            return lhs.occurrenceCount > rhs.occurrenceCount
        }
    }
    
}
