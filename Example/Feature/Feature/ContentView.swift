//
//  ContentView.swift
//  Feature
//
//  Created by Артём Черныш on 16.01.24.
//

import SwiftUI
import FeatureList

struct ContentView: View {
    var body: some View {
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
}

#Preview {
    ContentView()
}
