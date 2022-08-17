//
//  SuffixSequence.swift
//  SuffixSequence
//
//  Created by Андрей Парчуков on 18.08.2022.
//

struct SuffixSequence: Sequence {
    
    let word: String
    
    func makeIterator() -> SuffixIterator {
        SuffixIterator(self)
    }
    
}

struct SuffixIterator: IteratorProtocol {
    
    let suffixSequence: SuffixSequence
    var startIndex: String.Index
    
    init(_ sequence: SuffixSequence) {
        suffixSequence = sequence
        startIndex = sequence.word.startIndex
    }
    
    mutating func next() -> String? {
        let string = suffixSequence.word
        guard !string.isEmpty else { return nil }
        
        let suffix = string.suffix(from: startIndex)
        if !suffix.isEmpty {
            startIndex = string.index(after: startIndex)
            return String(suffix)
        } else {
            return nil
        }
    }
    
}
