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
            InputScreen(viewModel: viewModel)
                .tag(TabScreen.enterText)
                .tabItem {
                    Label("Input", systemImage: "square.and.pencil")
                }
            
            ResultScreen(viewModel: viewModel)
                .tag(TabScreen.results)
                .tabItem {
                    Label("Resuts", systemImage: "list.dash")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
