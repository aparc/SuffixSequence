//
//  SuffixOccurrence.swift
//  SuffixSequence
//
//  Created by Андрей Парчуков on 18.08.2022.
//

import Foundation


struct SuffixOccurrence: Codable, Identifiable {
    
    var id: UUID = .init()
    
    let suffix: String
    let occurrenceCount: Int
    var searchExecutionTime: CFTimeInterval = 0
    
    var formattedExecutionTime: String {
        String(format: "%.2f", searchExecutionTime * 1000)
    }
    
}

extension SuffixOccurrence: Comparable {
    
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
