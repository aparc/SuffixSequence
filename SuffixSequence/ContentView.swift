//
//  ContentView.swift
//  SuffixSequence
//
//  Created by Андрей Парчуков on 06.08.2022.
//

import SwiftUI
import Combine

enum SuffixResult: String, CaseIterable, Identifiable {
	
	var id: Self {
		self
	}
	
	case all = "All Suffixes"
	case top10 = "Top 10"
}

struct SuffixSequence: Sequence {
    
    let word: String
    
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
        startIndex = sequence.word.startIndex
    }
    
    mutating func next() -> String? {
        let letter = suffixSequence.word
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

let sequence = SuffixSequence(word: "word")

final class SuffixViewModel: ObservableObject {
    
    @Published var text: String = .init()
	@Published var suffixes: [String:Int] = .init()
    
    private var subscriptions: Set<AnyCancellable> = .init()
    
    init() {
        $text
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map { t -> [SuffixSequence] in
				t
					.split(separator: " ")
                    .map { SuffixSequence(word: String($0)) }
            }
            .sink { [weak self] suffixSequences in
				let t = suffixSequences
					.flatMap { $0 }
					.filter{ $0.count > 2 }
					.reduce(into: [:]) { counts, suffix in
						counts[suffix, default: 0] += 1
					}
				self?.suffixes = t
            }
            .store(in: &subscriptions)
    }
    
}

struct ContentView: View {
    
    @ObservedObject var viewModel: SuffixViewModel = .init()
    
    @State var tabSelection: Int = 0
	@State var result: SuffixResult = .all
    
    var body: some View {
		TabView(selection: $tabSelection) {
			TextEditor(text: $viewModel.text)
				.border(.gray, width: 2.0)
				.padding()
				.frame(height: 500)
				.tabItem {
					Image(systemName: "text.magnifyingglass")
					Text("Input")
				}
			
			VStack(alignment: .leading) {
				Text("Results")
					.font(.largeTitle)
					.bold()
				Picker("Ass", selection: $result) {
					ForEach(SuffixResult.allCases) { result in
						Text(result.rawValue)
					}
				}
				.pickerStyle(.segmented)
				
				ScrollView(.vertical, showsIndicators: false) {
					
				}
			}
			.padding()
			.tabItem {
				Image(systemName: "list.dash")
				Text("Results")
			}
		}
		
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
