//
//  ContentView.swift
//  AttributedTextExample
//
//  Created by Никита Белокриницкий on 09.05.2021.
//

import SwiftUI
import AttributedText

struct ContentView: View {
    var body: some View {
        AttributedText("<h1>A unit</h1> of <i>length</i> <unknown>equal to</unknown> <b>one hundred-millionth of a centimetre</b>, 10<sup>−10</sup> metre, used mainly to express <u>wavelengths and interatomic distances</u>.")
            .foregroundColor(.red)
            .font(.title3)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//            .previewLayout(PreviewLayout.fixed(width: 350, height: 150))
    }
}
