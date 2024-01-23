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
        
    var body: some View {
        VStack {
            HStack {
                Image(systemName: model.image)
                Text(model.title)
                    .font(.system(.title3, design: .rounded))
                    .lineLimit(1)
                Spacer()
            }
            .frame(maxWidth: .infinity)
        }
    }
    
}

private var bindModel: Binding<String?> = Binding<String?>.init {
    ""
} set: { _ in
    
}

#Preview {
    Row(model: .init(id: "Map", image: "globe", title: "Map"))
}
