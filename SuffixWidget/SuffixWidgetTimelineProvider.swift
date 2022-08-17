//
//  SuffixWidgetTimelineProvider.swift
//  SuffixWidgetExtension
//
//  Created by Андрей Парчуков on 17.08.2022.
//

import WidgetKit

struct SuffixWidgetTimelineProvider: TimelineProvider {
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(
            date: Date(),
            suffixOccurrences: [
                SuffixOccurrence(suffix: "bra", occurrenceCount: 2),
                SuffixOccurrence(suffix: "kad.", occurrenceCount: 3),
                SuffixOccurrence(suffix: "bol", occurrenceCount: 5),
                SuffixOccurrence(suffix: "bras", occurrenceCount: 1),
                SuffixOccurrence(suffix: "kado.", occurrenceCount: 6)
            ]
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let data = loadData()
        let entry = SimpleEntry(date: Date(), suffixOccurrences: data)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        var entries: [SimpleEntry] = []
        let data = loadData()
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, suffixOccurrences: data)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    private func loadData() -> [SuffixOccurrence] {
        let data = SuffixStorageService.shared.load()
            .sorted { $0.occurrenceCount > $1.occurrenceCount }
            .prefix(10)
            .sorted { Sort.desc.compare($0, $1) }
            .prefix(5)
        
        return Array(data)
    }
    
}
