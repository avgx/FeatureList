//
//  FeatureListDialog.swift
//
//
//  Created by Alexey Govorovsky on 29.12.2023.
//

import SwiftUI

public struct FeatureListDialog: View {
    @Environment(\.dismiss) private var dismiss
    
    @State
    private var editMode: EditMode = .active
    
    @Binding
    var models: [FeatureList.Model]
    
    public init(models: Binding<[FeatureList.Model]>) {
        self._models = models
    }
    
    var fixedModels: [FeatureList.Model] {
        get {
            guard let otherIndex: Int = models.firstIndex(where: { $0 == .other }) else {
                return []
            }
            
            var list = models.prefix(upTo: otherIndex)
            list.removeFirst()
            return Array(list)
        }
    }
    
    var other: [FeatureList.Model] {
        get {
            guard let otherIndex: Int = models.firstIndex(where: { $0 == .other }) else {
                return []
            }
            
            var list = models.suffix(from: otherIndex)
            list.removeFirst()
            return Array(list)
        }
    }
    
    public var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                content
            }
        } else {
            // Fallback on earlier versions
            NavigationView {
                content
            }
            .navigationViewStyle(.stack)
        }
    }
    
    @ViewBuilder
    var content: some View {
        VStack {
            List {
                ForEach(models, id: \.id) { model in
                    FeatureList.Row(model: model)
                        .moveDisabled(model == .other || model == .selected)
                        .id(model.id)
                }
                .onMove(perform: { indices, newOffset in
                    moveItem(from: indices, to: newOffset)
                })
            }
            VStack {
                Text("Navigation preview")
                    .font(.title2)
                    .bold()
                TabView(selection: .constant("Plan")) {
                    ForEach(fixedModels, id: \.title) { item in
                        Text("")
                            .tabItem {
                                Image(systemName: item.image)
                                Text(item.title)
                            }
                            .tag(item.id)
                    }
                    Text("")
                        .tabItem {
                            Image(systemName: "person")
                            Text("profile")
                        }
                        .tag("profile")
                }
                .tint(Color.secondary)
                .disabled(true)
                .frame(height: 44)
                .frame(maxWidth: .infinity)
            }
        }
        .navigationTitle("Edit navigation")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark")
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                EditButton()
            }
        }
        .deleteDisabled(true)
        .environment(\.editMode, $editMode)
        .onChange(of: editMode, perform: { value in
            if value.isEditing {
            } else {
                dismiss()
            }
        })
    }
    
    private func moveItem(from source: IndexSet, to destination: Int) {
        models.move(fromOffsets: source, toOffset: destination)
        let count = fixedModels.count
        
        if let moveIndex = source.first,
           (count < 2 || count > 4) {
            models.move(fromOffsets: IndexSet(integer: destination - 1), toOffset: moveIndex)
        }
    }
}

let mockData: [FeatureList.Model] = [
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
    FeatureListDialog(models: Binding<[FeatureList.Model]>.constant(mockData))
}
