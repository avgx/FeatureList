// The Swift Programming Language
// https://docs.swift.org/swift-book
import SwiftUI

public struct FeatureList: View {
    let openFullScreen: (Model) -> ()
    
    public init(model: Binding<[Model]>, edit: Binding<Bool>, openFullScreen: @escaping (Model) -> ()) {
        self._model = model
        self._edit = edit
        self.openFullScreen = openFullScreen
    }
    
    @Binding
    private var edit: Bool
    
    @Binding
    public var model: [Model]
    
    var other: [Model] {
        get {
            guard let otherIndex: Int = model.firstIndex(where: { element in
                element == .other
            })
            else { return [] }
            
            var list = model.suffix(from: otherIndex)
            list.removeFirst()
            return Array(list)
        }
    }
    
    public var body: some View {
        Section(content: {
            ForEach(other, id: \.title) { item in
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
                
                FeatureList(model: Binding.constant(mockData), edit: .constant(false), openFullScreen: { x in })
            }
        }
        .navigationViewStyle(.stack)
    }
    .tint(Color.orange)
    
}
