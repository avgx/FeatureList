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
    var data: [Model] = mockData
    
    @State private var editMode: EditMode = .active
    
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
                Section {
                    ForEach(data.prefix(3), id: \.title) { item in
                        HStack(spacing: 8) {
                            Button(action: { }) {
                                Image(systemName: "minus.circle.fill")
                                    .tint(Color(UIColor.systemRed))
                            }
                            Row(model: item)
                                .frame(maxWidth: .infinity)
                            Spacer()
                        }
                    }
                    .onMove { moveItem(from: $0, to: $1) }
                    //                        .onDelete { deleteItem(at: $0) }
                }
                Section(header: Text("Other")){
                    ForEach(data.suffix(data.count - 3), id: \.title) { item in
                        HStack(spacing: 8) {
                            Button(action: { }) {
                                Image(systemName: "plus.circle.fill")
                                    .tint(Color(UIColor.systemGreen))
                            }
                            Row(model: item)
                        }
                    }
                    .onMove { moveItem(from: $0, to: $1) }
                    //                        .onDelete { deleteItem(at: $0) }
                }
                
            }
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            VStack {
                Text("Navigation preview")
                    .font(.title2)
                TabView(selection: .constant(-1)) {
                    ForEach(data.prefix(3), id: \.title) { item in
                        Text("")
                            .tabItem {
                                Image(systemName: item.image)
                                Text(item.title)
                            }
                            .tag(item.id)
                            .tint(.accentColor)
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
            
            //.listStyle(.grouped)
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
            //You need to be careful, and make sure .environment(\.editMode, self.$isEditMode) comes after .navigationBarItems(trailing: EditButton()).
            //https://stackoverflow.com/a/57498356/2060780
            .environment(\.editMode, $editMode)
            //.frame(maxHeight: 300)    
            .onChange(of: editMode, perform: { value in
              if value.isEditing {
                 // Entering edit mode (e.g. 'Edit' tapped)
              } else {
                 // Leaving edit mode (e.g. 'Done' tapped)
                  dismiss()
              }
            })
    }
    
    func moveItem(from source: IndexSet, to destination: Int) {
        //fruits.move(fromOffsets: source, toOffset: destination)
        print("move \(source.first) -> \(destination)")
    }
    func deleteItem(at offset: IndexSet) {
        //fruits.remove(atOffsets: offset)
        print("delete \(offset.first)")
    }
}

#Preview {
    FeatureListDialog()
}
