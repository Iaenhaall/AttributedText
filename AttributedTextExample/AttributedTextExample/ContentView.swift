//
//  ContentView.swift
//  AttributedTextExample
//
//  Created by Никита Белокриницкий on 09.05.2021.
//

import SwiftUI
import AttributedText

struct ContentView: View {
    private let text: String = "<h1>A unit</h1> of <i>length</i> <unknown>equal to</unknown> <b>one hundred-millionth of a centimetre</b>, 10<sup>−10</sup> metre, used mainly to express <u>wavelengths and interatomic distances</u>."
    private let tags: Dictionary<String, (Text) -> (Text)> = [
        "h1": { $0.italic() },
        "i": { $0.foregroundColor(.orange) },
        "u": { $0.foregroundColor(.purple) },
        "b": { $0.foregroundColor(.yellow) },
        "sup": { $0.bold() }
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            Group {
                // Uses the default values.
                AttributedText(text)
                
                Divider()
                
                // Uses the default values, augmented by the standard foregroundColor and font modifiers.
                AttributedText(text)
                    .foregroundColor(.red)
                    .font(.title3)
                
                Divider()
                
                // Uses its custom modifiers.
                AttributedText(text, tags: tags)
            }
            .fixedSize(horizontal: false, vertical: true)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//            .previewLayout(PreviewLayout.fixed(width: 350, height: 150))
    }
}
