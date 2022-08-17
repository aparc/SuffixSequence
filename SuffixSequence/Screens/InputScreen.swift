//
//  InputScreen.swift
//  SuffixSequence
//
//  Created by Андрей Парчуков on 11.08.2022.
//

import SwiftUI

struct InputScreen: View {
    
    @ObservedObject var viewModel: SuffixViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Enter text")
                    .bold()
                    .font(.largeTitle)
                Spacer()
            }
            
            TextEditor(text: $viewModel.text)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke())
                .frame(height: 500)
            
            Spacer()
        }
        .padding()
    }
}

struct InputScreen_Previews: PreviewProvider {
    static var previews: some View {
        InputScreen(viewModel: .init())
    }
}
