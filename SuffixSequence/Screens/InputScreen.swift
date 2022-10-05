//
//  InputScreen.swift
//  SuffixSequence
//
//  Created by Андрей Парчуков on 11.08.2022.
//

import SwiftUI

struct InputScreen: View {
    
    @EnvironmentObject var viewModel: SuffixViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    TextEditor(text: $viewModel.text)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke())
                        .frame(height: 500)
                    .navigationTitle("Enter text")
                    Spacer()
                }
                .padding()
            }
        }
    } // body
}

struct InputScreen_Previews: PreviewProvider {
    static var previews: some View {
        InputScreen()
    }
}
