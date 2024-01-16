// The Swift Programming Language
// https://docs.swift.org/swift-book
import SwiftUI

public struct FeatureList: View {
    
    public init() {
        
    }
    
    @State
    var edit: Bool = false
    
    @State
    var model: [Model] = mockData
    
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
                
                FeatureList()
            }
        }
        .navigationViewStyle(.stack)
    }
    .tint(Color.orange)
    
}
