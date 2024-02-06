//
//  File.swift
//  
//
//  Created by Alexey Govorovsky on 29.12.2023.
//

import Foundation

extension FeatureList {
    public struct Model: Identifiable, Hashable, Codable {
        
        public static let other: Model = .init(id: "Other", image: "x.circle", title: "Other")
        public static let selected: Model = .init(id: "Selected", image: "x.circle", title: "Selected")
        
        public let id: String
        public let image: String
        public let title: String
        
        public init(id: String, image: String, title: String) {
            self.id = id
            self.image = image
            self.title = title
        }
    }
}

extension FeatureList.Model: Equatable {
    public static func == (lhs: FeatureList.Model, rhs: FeatureList.Model) -> Bool {
        return lhs.title == rhs.title &&
               lhs.id == rhs.id &&
               lhs.image == rhs.image
    }
}
