//
//  ContentView.swift
//  Feature
//
//  Created by Артём Черныш on 16.01.24.
//

import SwiftUI
import FeatureList

struct ContentView: View {
    
    @AppStorage("settingsData")
    private var settingsData: [FeatureList.Model] = testData
    
    @State
    private var selectedItem: FeatureList.Model?
    
    @State
    private var edit = false
    
    var body: some View {
        Group {
            NavigationView {
                List {
                    Section {
                        Text("Select screens order with button")
                        Text("Tap to open screen")
                    }
                    FeatureList(model: $settingsData, edit: $edit, openFullScreen: openFullScreen)
                        
                }
                .navigationViewStyle(.stack)
            }
            .tint(Color.orange)
        }
        .sheet(isPresented: $edit, onDismiss: {
            print("onDismiss")
            edit = false
        }, content: {
            FeatureListDialog(models: $settingsData)
        })
        .fullScreenCover(item: $selectedItem) { item in
            NavigationView {
                Text(item.title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button(action: {
                                selectedItem = nil
                            }) {
                                Image(systemName: "xmark")
                            }
                        }
                    }
            }
        }
    }

    private func openFullScreen(item: FeatureList.Model) {
        selectedItem = item
    }
}

let testData: [FeatureList.Model] = [
                .selected,
                .init(id: "Map", image: "globe", title: "Map"),
                .init(id: "Plan", image: "map", title: "Plan"),
                .init(id: "Dashboards", image: "square.grid.3x3.fill", title: "Dashboards"),
                .other,
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
