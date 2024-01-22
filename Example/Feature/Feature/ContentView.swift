//
//  ContentView.swift
//  Feature
//
//  Created by Артём Черныш on 16.01.24.
//

import SwiftUI
import FeatureList

struct ContentView: View {
    var body: some View {
        Group {
            NavigationView {
                List {
                    Section {
                        Text("Select screens order with button")
                        Text("Tap to open screen")
                    }
                    FeatureList(model: testData)
                }
            }
            .navigationViewStyle(.stack)
        }
        .tint(Color.orange)
    }
}

let testData: [Model] = [.init(id: "Map", image: "globe", title: "Map"),
                .init(id: "Plan", image: "map", title: "Plan"),
                .init(id: "Dashboards", image: "square.grid.3x3.fill", title: "Dashboards"),
                .init(id: "Other", image: "x.circle", title: "Other"),
                .init(id: "Cameras", image: "video.fill", title: "Cameras"),
                .init(id: "All cameras", image: "video.fill.badge.ellipsis", title: "All cameras"),
                .init(id: "Actions", image: "bolt.fill", title: "Actions"),
                .init(id: "Events", image: "rectangle.3.group.fill", title: "Events"),
                .init(id: "Alerts", image: "exclamationmark.triangle", title: "Alerts"),
                .init(id: "Face search", image: "person.crop.circle.badge.questionmark", title: "Face search"),
                .init(id: "Lpr search", image: "car", title: "Lpr search"),
                .init(id: "Persons", image: "person.text.rectangle", title: "Persons"),
                .init(id: "Translation", image: "dot.radiowaves.left.and.right", title: "Translation"),
                .init(id: "Audit", image: "lock.open.display", title: "Audit"),
                .init(id: "Bookmarks", image: "bookmark", title: "Bookmarks"),
                .init(id: "Statistics", image: "chart.xyaxis.line", title: "Statistics")
            ]

#Preview {
    ContentView()
}
