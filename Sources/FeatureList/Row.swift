//
//  SwiftUIView.swift
//  
//
//  Created by Alexey Govorovsky on 29.12.2023.
//

import SwiftUI


struct Row: View {
    let model: Model
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: model.image)
            Text(model.title)
                .font(.system(.title3, design: .rounded))
                .lineLimit(1)
                //.frame(maxWidth: .infinity)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .id(model.id)
    }
}


#Preview {
    Row(model: .init(id: "Map", image: "globe", title: "Map"))
}
