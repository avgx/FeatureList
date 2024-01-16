//
//  SwiftUIView.swift
//
//
//  Created by Alexey Govorovsky on 29.12.2023.
//
import SwiftUI
import UniformTypeIdentifiers

struct Row: View {
    let model: Model
    
    @Binding
    var models : [Model]
    
    @Binding
    var draggedModel : String?
    
    @Environment(\.editMode)
    private var editMode
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: model.image)
                Text(model.title)
                    .font(.system(.title3, design: .rounded))
                    .lineLimit(1)
                Spacer()
                if editMode?.wrappedValue == .active {
                    Image(systemName: "line.3.horizontal")
                }
            }
            .onDrag({
                if editMode?.wrappedValue == .active, let otherIndex: Int = models.firstIndex(where: { element in
                        element.id == "Other"
                    }), 
                    let actualIndex: Int = models.firstIndex(where: { element in
                        element.title == model.title
                    }) , otherIndex > 2 ||
                    actualIndex > otherIndex {
                    self.draggedModel = model.title
                } else {
                    self.draggedModel = nil
                }
                return NSItemProvider(item: nil, typeIdentifier: model.id)
            })
            .onDrop(of: [UTType.text], delegate: MyDropDelegate(model: model, models: $models, draggedModel: $draggedModel))
            .frame(maxWidth: .infinity)
            RoundedRectangle(cornerRadius: 1)
                .foregroundColor( Color( UITableView().separatorColor ?? .gray) )
                .frame(height: 1)
        }
    }
    
    struct MyDropDelegate : DropDelegate {
        
        let model : Model
        
        @Binding
        var models : [Model]
        
        @Binding
        var draggedModel : String?
        
        func performDrop(info: DropInfo) -> Bool {
            return true
        }
        
        func dropEntered(info: DropInfo) {
            guard let draggedModel = self.draggedModel,
                  let from: Int = models.firstIndex(where: { element in
                      element.title == draggedModel
                  }) ,
                  let to: Int = models.firstIndex(where: { element in
                      element.title == model.title
                  })
            else { return }
            if draggedModel != model.title {
                withAnimation(.smooth) {
                    self.models.move(fromOffsets: IndexSet(integer: from), toOffset: to > from ? to + 1 : to)
                }
            }
        }
    }
}

private var bindModel: Binding<String?> = Binding<String?>.init {
    ""
} set: { _ in
    
}

#Preview {
    Row(model: .init(id: "Map", image: "globe", title: "Map"), models: Binding<[Model]>.constant([]), draggedModel: bindModel)
}
