//
//  ContentView.swift
//  SuffixSequence
//
//  Created by Андрей Парчуков on 06.08.2022.
//

import SwiftUI
import Combine

struct SuffixSequence: Sequence {
    
    let letter: String
    
    func suffixArray() -> [Int] {
        self.enumerated()
            .sorted { $0.element < $1.element }
            .map { $0.offset }
    }
    
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

final class SuffixViewModel: ObservableObject {
    
    @Published var text: String = .init()
    
    private var subscriptions: Set<AnyCancellable> = .init()
    
    init() {
        $text
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map { t -> [SuffixSequence] in
                t
                    .trimmingCharacters(in: .punctuationCharacters)
                    .split(separator: " ")
                    .map { SuffixSequence(letter: String($0)) 	}
            }
            .sink { [weak self] t in
                print(t)
            }
            .store(in: &subscriptions)
    }
    
}

struct ContentView: View {
    
    @ObservedObject var viewModel: SuffixViewModel = .init()
    
    @State var tabSelection: Int = 0
    
    var body: some View {
        TextEditor(text: $viewModel.text)
            .border(.gray, width: 2.0)
            .padding()
            .frame(height: 500)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
