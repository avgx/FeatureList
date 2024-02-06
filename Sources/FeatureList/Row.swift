//
//  SwiftUIView.swift
//
//
//  Created by Alexey Govorovsky on 29.12.2023.
//
import SwiftUI
import UniformTypeIdentifiers

extension FeatureList {
    struct Row: View {
        let model: Model
        
        var body: some View {
            VStack {
                HStack {
                    if model == .other || model == .selected {
                        Text(model.title)
                            .font(.subheadline)
                            .padding([.top])
                    } else {
                        Image(systemName: model.image)
                        Text(model.title)
                            .font(.system(.title3, design: .rounded))
                            .lineLimit(1)
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
        }
        
    }
}

#Preview {
    FeatureList.Row(model: .init(id: "Map", image: "globe", title: "Map"))
}
