//
//  TimeMeasureScreen.swift
//  SuffixSequence
//
//  Created by Андрей Парчуков on 05.10.2022.
//

import SwiftUI

struct ExecutionTimeResultScreen: View {
    
    @EnvironmentObject var viewModel: SuffixViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(Array(suffixes.enumerated()), id: \.offset) { index, element in
                    HStack {
                        Text(element.suffix)
                        Spacer()
                        Text(element.formattedExecutionTime + " ms")
                    }
                    .listRowBackground(
                        Color.init(
                            hue: Double(suffixes.count-1-index) / Double(suffixes.count - 1) / 3.0,
                            saturation: 0.25,
                            brightness: 1)
                    )
                }
            }
            .navigationTitle("Execution Time")
        }
    }
    
    private var suffixes: [SuffixOccurrence] {
        viewModel.suffixes.sorted {
            $0.searchExecutionTime < $1.searchExecutionTime
        }
    }
    
}

struct TimeMeasureScreen_Previews: PreviewProvider {
    static var previews: some View {
        ExecutionTimeResultScreen()
    }
}
