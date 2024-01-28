//
//  FeatureListDialog.swift
//
//
//  Created by Alexey Govorovsky on 29.12.2023.
//

import SwiftUI

struct FeatureListDialog: View {
    @Environment(\.dismiss) private var dismiss
    
    @State
    private var editMode: EditMode = .active
    
    @Binding
    var models: [Model]
    
    var fixedModels: [Model] {
        get {
            guard let otherIndex: Int = models.firstIndex(where: { element in
                element == Model.other
            })
            else { return [] }
            
            var fixed: [Model] = []
            
            for model in models {
                if let itemIndex: Int = models.firstIndex(where: { element in
                    element == model
                }), itemIndex < otherIndex,
                   model != Model.selected {
                    fixed.append(model)
                }
            }
            return fixed
        }
    }
    
    var body: some View {
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
                    Row(model: model)
                        .moveDisabled(model == Model.other || model == Model.selected)
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
        if let moveIndex = source.first,
           let otherIndex: Int = models.firstIndex(where: { element in
               element == Model.other
           }),
           otherIndex < 3,
           moveIndex <= otherIndex {
            models.move(fromOffsets: IndexSet(integer: destination - 1), toOffset: moveIndex)
        }
    }
}

#Preview {
    FeatureListDialog(models: Binding<[Model]>.constant(mockData))
}
