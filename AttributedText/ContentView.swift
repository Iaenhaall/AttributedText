//
//  ContentView.swift
//  AttributedText
//
//  Created by Никита Белокриницкий on 11.03.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        AttributedText("A unit of <i>length</i> equal to <b>one hundred-millionth of a centimetre</b>, 10<sup>−10</sup> metre, used mainly to express <u>wavelengths and interatomic distances</u>.")
            .foregroundColor(.blue)
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
