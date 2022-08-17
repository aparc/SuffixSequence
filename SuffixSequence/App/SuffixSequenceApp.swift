//
//  SuffixSequenceApp.swift
//  SuffixSequence
//
//  Created by Андрей Парчуков on 06.08.2022.
//

import SwiftUI

@main
struct SuffixSequenceApp: App {
    
    @ObservedObject private var tabRouter: TabRouterViewModel = .init()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(tabRouter)
                .onOpenURL { url in
                    guard let selection = TabScreen(rawValue: url.absoluteString) else { return }
                    tabRouter.tabSelection = selection
                }
        }
    }
}
