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
            .map { text -> SuffixSequence in
                SuffixSequence(word: text)
            }
            .sink { [unowned self] suffixSequence in
                let suffixArray = suffixSequence.suffixArray()
                
                let threeMoreLengthSuffixes = text
                    .split { !$0.isLetter }
                    .map { String($0) }
                    .filter { $0.count > 2 }
                
                let uniqueSuffixes = Set(threeMoreLengthSuffixes)
                
                let jobs = uniqueSuffixes.map { suffix in
                    Job(text: text, suffixArray: suffixArray, substring: suffix)
                }
                
                JobScheduler.shared.execute(jobs) {
                    suffixes = $0
                    if !self.suffixes.isEmpty {
                        SuffixStorageService.shared.save(data: suffixes)
                        WidgetCenter.shared.reloadTimelines(ofKind: "SuffixWidget")
                    }
                }
            }
            .store(in: &subscriptions)
    }
    
}
