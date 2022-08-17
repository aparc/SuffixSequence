//
//  Sort.swift
//  SuffixSequence
//
//  Created by Андрей Парчуков on 18.08.2022.
//


enum Sort {
    case asc
    case desc
    
    mutating func toggle() {
        self = self == .asc ? .desc : .asc
    }
    
    func compare<T: Comparable>(_ lhs: T, _ rhs: T) -> Bool {
        switch self {
        case .asc: return lhs < rhs
        case .desc: return lhs > rhs
        }
    }
    
}
