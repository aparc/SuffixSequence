//
//  SuffixViewModel.swift
//  SuffixSequence
//
//  Created by Андрей Парчуков on 11.08.2022.
//

import Combine
import WidgetKit

final class SuffixViewModel: ObservableObject {
    
    @Published var text: String = .init()
    @Published var suffixes: [SuffixOccurrence] = SuffixStorageService.shared.load()
    
    private var subscriptions: Set<AnyCancellable> = .init()
    
    init() {
        $text
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map { t -> [SuffixSequence] in
                t
                    .split(separator: " ")
                    .map { SuffixSequence(word: String($0)) }
            }
            .sink { [unowned self] suffixSequences in
                let t = suffixSequences
                    .flatMap { $0 }
                    .filter{ $0.count > 2 }
                    .reduce(into: [:]) { counts, suffix in
                        counts[suffix, default: 0] += 1
                    }.map {
                        SuffixOccurrence(suffix: $0.key, occurrenceCount: $0.value)
                    }
                    
                self.suffixes = t
                if !self.suffixes.isEmpty {
                    SuffixStorageService.shared.save(data: suffixes)
                    WidgetCenter.shared.reloadTimelines(ofKind: "SuffixWidget")
                }
            }
            .store(in: &subscriptions)
    }
    
}
