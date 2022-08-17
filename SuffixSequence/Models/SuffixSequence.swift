//
//  SuffixSequence.swift
//  SuffixSequence
//
//  Created by Андрей Парчуков on 18.08.2022.
//

struct SuffixSequence: Sequence {
    
    let word: String
    
    func makeIterator() -> SuffixIterator {
        SuffixIterator(suffixSequence: self)
    }
    
}

struct SuffixIterator: IteratorProtocol {
    
    let suffixSequence: SuffixSequence
    var startIndex: Int = 0
    
    mutating func next() -> String? {
        guard startIndex < suffixSequence.word.count else { return nil }
        startIndex += 1
        return String(suffixSequence.word.suffix(startIndex))
    }
    
}
