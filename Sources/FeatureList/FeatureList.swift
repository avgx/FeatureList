// The Swift Programming Language
// https://docs.swift.org/swift-book
import SwiftUI

public struct FeatureList: View {
    
    public init(model: [Model]) {
        self.model = model
    }
    
    @State
    private var edit: Bool = false
    
    @State
    private var selectedItem: Model?
    
    @State
    public var model: [Model]
    
    public var body: some View {
        Section(content: {
            ForEach(model, id: \.title) { item in
                if item.title == "Other" {
                    Text(item.title)
                        .font(.bold(.title2)())
                        .padding([.top])
                        .id(item.id)
                } else {
                    HStack {
                        Image(systemName: item.image)
                        Text(item.title)
                            .font(.system(.title3, design: .rounded))
                            .lineLimit(1)
                        Spacer()
                    }
                    .id(item.id)
                    .onTapGesture {
                        selectedItem = item
                    }
                }
            }
        }, header: {
            HStack {
                Spacer()
                Button(action: { edit.toggle() }) {
                    Image(systemName: "arrow.up.and.down.text.horizontal")
                }
            }
        })
        .fullScreenCover(item: $selectedItem, content: { item in
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
        })
        .sheet(isPresented: $edit, onDismiss: {
            print("onDismiss")
            edit = false
        }, content: {
            FeatureListDialog(models: $model)
        })
    }
}

#Preview {
    Group {
        NavigationView {
            List {
                Section {
                    Text("Select screens order with button")
                    Text("Tap to open screen")
                }
                
                FeatureList(model: mockData)
            }
        }
        .navigationViewStyle(.stack)
    }
    .tint(Color.orange)
    
}
