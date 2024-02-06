// The Swift Programming Language
// https://docs.swift.org/swift-book
import SwiftUI

public struct FeatureList: View {
    let openFullScreen: (Model) -> ()
    
    public init(model: Binding<[Model]>, openFullScreen: @escaping (Model) -> ()) {
        self._model = model
        self.openFullScreen = openFullScreen
    }
    
    @State
    private var edit: Bool = false
    
    @Binding
    public var model: [Model]
    
    public var body: some View {
        Section(content: {
            ForEach(model, id: \.title) { item in
                Row(model: item)
                    .id(item.id)
                    .onTapGesture {
                        if item != Model.other && item != Model.selected {
                            openFullScreen(item)
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
                
                FeatureList(model: Binding.constant(mockData), openFullScreen: { x in })
            }
        }
        .navigationViewStyle(.stack)
    }
    .tint(Color.orange)
    
}
