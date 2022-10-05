//
//  WidgetLink.swift
//  SuffixSequence
//
//  Created by Андрей Парчуков on 17.08.2022.
//

enum TabScreen: String, CaseIterable, Identifiable {
    
    case enterText
    case results
    case timeMeasurement
    
    var id: Self { self }
    
}
