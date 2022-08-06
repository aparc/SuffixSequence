//
//  ContentView.swift
//  SuffixSequence
//
//  Created by Андрей Парчуков on 06.08.2022.
//

import SwiftUI

struct SuffixSequence: Sequence {
    
    let letter: String
    
    func makeIterator() -> SuffixIterator {
        SuffixIterator(self)
    }
    
}

struct SuffixIterator: IteratorProtocol {
    
    let suffixSequence: SuffixSequence
    var startIndex: String.Index
    
    init(_ sequence: SuffixSequence) {
        suffixSequence = sequence
        startIndex = sequence.letter.startIndex
    }
    
    mutating func next() -> String? {
        let letter = suffixSequence.letter
        guard !letter.isEmpty else { return nil }
        
        let suffix = letter.suffix(from: startIndex)
        if !suffix.isEmpty {
            startIndex = letter.index(after: startIndex)
            return String(suffix)
        } else {
            return nil
        }
    }
    
}

let sequence = SuffixSequence(letter: "word")


struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
