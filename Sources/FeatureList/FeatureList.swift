// The Swift Programming Language
// https://docs.swift.org/swift-book
import SwiftUI

struct FeatureList: View {
    
    @State
    var edit: Bool = false
    
    @State
    var model: [Model] = mockData
    
    var body: some View {
        Section(content: {
            ForEach(model, id: \.title) { item in
                Row(model: item)
                    .onTapGesture {
                        print(item.id)
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
            FeatureListDialog()
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
