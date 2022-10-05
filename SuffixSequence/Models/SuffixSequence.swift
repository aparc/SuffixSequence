//
//  SuffixSequence.swift
//  SuffixSequence
//
//  Created by Андрей Парчуков on 18.08.2022.
//

struct SuffixSequence: Sequence {
    
    let word: String
    
    func makeIterator() -> SuffixIterator {
        SuffixIterator(word: word)
    }
    
    func suffixArray() -> [Int] {
        self
            .sorted { $0.suffix < $1.suffix }
            .map { $0.index }
    }
    
    func suffixes() -> [Suffix] {
        self.map { $0 }
    }
    
}

struct SuffixIterator: IteratorProtocol {
    
    let word: String
    var startIndex: Int = 0
    
    mutating func next() -> (suffix: String, index: Int)? {
        guard startIndex < word.count else { return nil }
        startIndex += 1
        let substring = word.suffix(startIndex)
        
        return Suffix(
            suffix: String(substring),
            index: word.count - startIndex
        )
    }
    
}

typealias Suffix = (suffix: String, index: Int)
