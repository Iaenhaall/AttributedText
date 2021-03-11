//
//  AttributedText.swift
//  AttributedText
//
//  Created by Никита Белокриницкий on 11.03.2021.
//

import SwiftUI

/**
 AttributedText is a view for displaying some HTML-tagged text using SwiftUI Text View.
 
 - warning: Only single-word tags are supported. Tags with more than one word or
 containing any characters besides letters are ignored and not deleted.
 
 # Notes: #
 1. Handles unopened/unclosed tags.
 2. Basic modifiers can still be applied, such as changing the font and color of the text.
 3. Deletes tags that have no modifiers.
 4. Does **not** handle HTML characters, for example `&lt;`.
 
 # Example #
 ```
 AttributedText("This is <b>bold</b> and <i>italic</i> text.")
     .foregroundColor(.blue)
     .font(.title)
     .padding()
 ```
 */
struct AttributedText: View {
    /// Parser formatted text.
    private let text: Text

    /**
     Creates a text view that displays formatted content.
     
     - parameter htmlString: HTML-tagged string.
     */
    init(_ htmlString: String) {
        let parser = HTML2TextParser(htmlString)
        parser.parse()
        text = parser.formattedText
    }

    var body: some View {
        text
    }
}

struct AttributedText_Previews: PreviewProvider {
    static var previews: some View {
        AttributedText("This is <b>bold</b> and <i>italic</i> text.")
            .foregroundColor(.blue)
            .font(.title)
            .padding()
    }
}
