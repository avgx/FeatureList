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
        ScrollView {
            LazyVStack {
                ForEach(models, id: \.id) { model in
                    if model.id == "Other" {
                        VStack {
                            HStack {
                                Text(model.title)
                                    .padding()
                                    .font(.bold(.title2)())
                                    .padding([.top])
                                    .id(model.id)
                                Spacer()
                            }
                            RoundedRectangle(cornerRadius: 1)
                                .foregroundColor( Color( UITableView().separatorColor ?? .gray) )
                                .frame(height: 1)
                        }
                    }
                    else {
                        Row(model: model, models: $models, draggedModel: $draggedModel)
                            .id(model.id)
                            .environment(\.editMode, $editMode)
                    }
                }
            }
            .padding()
            VStack {
                Text("Navigation preview")
                    .font(.title2)
                    .bold()
                TabView(selection: .constant(-1)) {
                    ForEach(models, id: \.title) { item in
                        if isItemBeforeOther(model: item) {
                            Text("")
                                .tabItem {
                                    Image(systemName: item.image)
                                    Text(item.title)
                                }
                                .tag(item.id)
                                .tint(.accentColor)
                        }
                    }
                    Text("")
                        .tabItem {
                            Image(systemName: "person")
                            Text("profile")
                        }
                        .tag("profile")
                        .tint(.accentColor)
                }
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
}

#Preview {
    FeatureListDialog(models: Binding<[Model]>.constant(mockData))
}
