//
//  AttributedTextExampleApp.swift
//  AttributedTextExample
//
//  Created by Никита Белокриницкий on 09.05.2021.
//

import SwiftUI
import AttributedText

@main
struct AttributedTextExampleApp: App {
    init() {
        // Uncomment to override the default modifier values.
//        AttributedText.tags = [
//            "h1": { $0.font(.footnote) },
//            "i": { $0.foregroundColor(.gray) },
//            "u": { $0.foregroundColor(.blue) },
//            "b": { $0.foregroundColor(.green) },
//            "sup": { $0.baselineOffset(-10).font(.title) }
//        ]
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
