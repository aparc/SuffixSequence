//
//  SuffixStorageService.swift
//  SuffixSequence
//
//  Created by Андрей Парчуков on 17.08.2022.
//

import Foundation

final class SuffixStorageService {
    
    private let localSuite: UserDefaults? = .init(suiteName: "group.ru.aparc.SuffixSequence")
    private let key: String = "suffixOccurrence"
    
    static let shared: SuffixStorageService = .init() 
    
    private init() {}
    
    func save(data: [SuffixOccurrence]) {
        guard let encoded = try? JSONEncoder().encode(data) else { return }
        localSuite?.set(encoded, forKey: key)
    }
    
    func load() -> [SuffixOccurrence] {
        guard let object = localSuite?.data(forKey: key) else { return [] }
        let decodedData = try? JSONDecoder().decode([SuffixOccurrence].self, from: object)
        return decodedData ?? []
    }
    
}

