//
//  SuffixWidget.swift
//  SuffixWidget
//
//  Created by Андрей Парчуков on 17.08.2022.
//

import WidgetKit
import SwiftUI

struct SimpleEntry: TimelineEntry {
    let date: Date
    let suffixOccurrences: [SuffixOccurrence]
}

@main
struct SuffixWidget: Widget {
    let kind: String = "SuffixWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: SuffixWidgetTimelineProvider()) { entry in
            SuffixWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Suffix Widget")
        .supportedFamilies([.systemMedium])
    }
}
