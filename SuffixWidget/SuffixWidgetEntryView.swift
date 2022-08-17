//
//  File.swift
//  SuffixSequence
//
//  Created by Андрей Парчуков on 17.08.2022.
//

import SwiftUI
import WidgetKit

struct SuffixWidgetEntryView : View {
    var entry: SuffixWidgetTimelineProvider.Entry
    
    var body: some View {
        HStack {
            suffixList
            Spacer()
            actions
        }
        .padding()
    } // body
    
    private var suffixList: some View {
        VStack(alignment: .leading) {
            Text("Suffix occurrences")
                .bold()
            Spacer()
            ForEach(entry.suffixOccurrences, id: \.suffix) { suffixOccurrence in
                Text("\(suffixOccurrence.suffix) - \(suffixOccurrence.occurrenceCount)")
                    .font(.body)
            }
            .padding(.horizontal, 16)
        }
        .frame(maxHeight: .infinity)
    }
    
    private var actions: some View {
        VStack(spacing: 20) {
            Group {
                ForEach(TabScreen.allCases) { link in
                    if let url = URL(string: link.rawValue) {
                        Link(destination: url) {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 40, height: 40)
                                .overlay(
                                    Image(systemName: link == .enterText ? "square.and.pencil":  "list.dash")
                                        .foregroundColor(.white)
                                )
                        }
                    }
                }
            }
        }
        .padding()
        .frame(maxHeight: .infinity)
        .background(
            Color(uiColor: .systemGray5)
                .cornerRadius(16)
        )
    }
}


struct SuffixWidgetEntryView_Previews: PreviewProvider {
    static var previews: some View {
        SuffixWidgetEntryView(
            entry: SimpleEntry(
                date: Date(),
                suffixOccurrences: [
                    SuffixOccurrence(suffix: "bra", occurrenceCount: 2),
                    SuffixOccurrence(suffix: "kad.", occurrenceCount: 3),
                    SuffixOccurrence(suffix: "bol", occurrenceCount: 5),
                    SuffixOccurrence(suffix: "bras", occurrenceCount: 1),
                    SuffixOccurrence(suffix: "kado.", occurrenceCount: 6)
                ]
            )
        )
        .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
