//
//  ContentView.swift
//  SuffixSequence
//
//  Created by Андрей Парчуков on 06.08.2022.
//

import SwiftUI

struct RootView: View {
    
    @StateObject var viewModel: SuffixViewModel = .init()
    @EnvironmentObject var tabRouter: TabRouterViewModel
    
    @State var tabSelection: Int = 0
    
    var body: some View {
        TabView(selection: $tabRouter.tabSelection) {
            InputScreen()
                .tag(TabScreen.enterText)
                .tabItem {
                    Label("Input", systemImage: "square.and.pencil")
                }
            
            SuffixOccurrenceResultScreen()
                .tag(TabScreen.results)
                .tabItem {
                    Label("Resuts", systemImage: "list.dash")
                }
            ExecutionTimeResultScreen()
                .tag(TabScreen.timeMeasurement)
                .tabItem {
                    Label("Times", systemImage: "clock.fill")
                }
        }
        .environmentObject(viewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
