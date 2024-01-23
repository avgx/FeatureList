//
//  FeatureListDialog.swift
//
//
//  Created by Alexey Govorovsky on 29.12.2023.
//

import SwiftUI

struct FeatureListDialog: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding
    var models: [Model]
    
    @State 
    private var draggedModel: String?
    
    @State
    private var editMode: EditMode = .active
    
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
                    if model.id == "Other" {
                        VStack {
                            HStack {
                                Text(model.title)
                                    .padding()
                                    .font(.bold(.title2)())
                                    .padding([.top])
                                Spacer()
                            }
                        }
                        .id(model.id)
                        .moveDisabled(true)
                    }
                    else {
                        Row(model: model)
                            .id(model.id)
                            .environment(\.editMode, $editMode)
                    }
                }
                .onMove(perform: { indices, newOffset in
                    moveItem(from: indices, to: newOffset)
                })
            }
            .id(UUID())
            VStack {
                Text("Navigation preview")
                    .font(.title2)
                    .bold()
                TabView(selection: .constant("Plan")) {
                    ForEach(models, id: \.title) { item in
                        if isItemBeforeOther(model: item) {
                            Text("")
                                .tabItem {
                                    Image(systemName: item.image)
                                    Text(item.title)
                                }
                                .tag(item.id)
                                .tint(Color(red: 153 / 255, green: 153 / 255, blue: 153 / 255))
                        }
                    }
                    Text("")
                        .tabItem {
                            Image(systemName: "person")
                            Text("profile")
                        }
                        .tag("profile")
                        .tint(Color(red: 153 / 255, green: 153 / 255, blue: 153 / 255))
                }
                .tint(Color(red: 153 / 255, green: 153 / 255, blue: 153 / 255))
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
    
    private func isItemBeforeOther(model: Model) -> Bool {
        guard let otherIndex: Int = models.firstIndex(where: { element in
                element.id == "Other"
            }),
            let actualIndex: Int = models.firstIndex(where: { element in
                element.title == model.title
            })
        else { return false }
        return actualIndex < otherIndex
    }
    
    private func moveItem(from source: IndexSet, to destination: Int) {
        models.move(fromOffsets: source, toOffset: destination)
        let otherIndex = checkOtherIndex()
        if let moveIndex = source.first,
           otherIndex < 2,
           moveIndex <= otherIndex {
            models.move(fromOffsets: IndexSet(integer: destination - 1), toOffset: moveIndex)
        }
    }
    
    private func checkOtherIndex() -> Int {
        guard let otherIndex: Int = models.firstIndex(where: { element in
                element.id == "Other"
            })
        else { return -1 }
        return otherIndex
    }
}

#Preview {
    FeatureListDialog(models: Binding<[Model]>.constant(mockData))
}
