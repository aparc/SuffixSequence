//
//  ResultScreen.swift
//  SuffixSequence
//
//  Created by Андрей Парчуков on 11.08.2022.
//

import SwiftUI
import WidgetKit

enum SuffixResultsSegment: String {
    case all = "All Suffixes"
    case top10 = "Top 10"
}

struct SuffixOccurrenceResultScreen: View {
    
    @EnvironmentObject var viewModel: SuffixViewModel
    
    @State private var selection: SuffixResultsSegment = .all
    @State private var sortDirection: Sort = .asc
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                picker
                suffixList
            }
            .navigationTitle("Last Results")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: changeSortDirection) {
                        Image(systemName: "arrow.up.arrow.down.circle")
                    }
                }
            }
        }
    } // body
    
    private var picker: some View {
        Picker("Results", selection: $selection) {
            Text(SuffixResultsSegment.all.rawValue).tag(SuffixResultsSegment.all)
            Text(SuffixResultsSegment.top10.rawValue).tag(SuffixResultsSegment.top10)
        }
        .padding()
        .pickerStyle(.segmented)
        .onChange(of: selection) { newValue in
            sortDirection = newValue == .all ? .asc : .desc
        }
    }
    
    private var suffixList: some View {
        List(getSuffixes()) { suffix in
            HStack {
                Text(suffix.suffix)
                Spacer()
                Text("\(suffix.occurrenceCount)")
                    .bold()
                    .opacity(suffix.occurrenceCount > 1 ? 1 : 0)
            }
        }
        .listStyle(.plain)
    }
    
    private func changeSortDirection() {
        sortDirection.toggle()
    }
    
    private func getSuffixes() -> [SuffixOccurrence] {
        switch selection {
        case .all:
            return viewModel.suffixes.sorted {
                if sortDirection == .asc {
                    return $0.suffix < $1.suffix
                } else {
                    return $0.suffix > $1.suffix
                }
            }
        case .top10:
            return viewModel.suffixes.sorted { $0.occurrenceCount > $1.occurrenceCount }
                .prefix(10)
                .sorted { sortDirection.compare($0, $1) }
        }
    }
    
}
