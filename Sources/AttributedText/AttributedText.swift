//
//  AttributedText.swift
//
//
//  Created by Никита Белокриницкий on 11.03.2021.
//

import SwiftUI

/**
 AttributedText is a view for displaying some HTML-tagged text using SwiftUI Text View.
 
 - warning: **Only single-word tags are supported**. Tags with more than one word or
 containing any characters besides **letters** or **numbers** are ignored and not removed.
 
 # Notes
 1. Basic modifiers can still be applied, such as changing the font and color of the text.
 2. Handles unopened/unclosed tags.
 3. Supports overlapping tags.
 4. Deletes tags that have no modifiers.
 5. Does **not** handle HTML characters such as `&amp;`.
 
 # Example
 ```
 AttributedText("This is <b>bold</b> and <i>italic</i> text.")
     .foregroundColor(.blue)
     .font(.title)
     .padding()
 ```
 */
public struct AttributedText: View {
    /// Set of supported tags and associated modifiers. This is used by default for all AttributedText
    /// instances except those for which this parameter is defined in the initializer.
    public static var tags: Dictionary<String, (Text) -> (Text)> = [
        // This modifier set is presented just for reference.
        // Set the necessary attributes and modifiers for your needs before use.
        "h1": { $0.font(.largeTitle) },
        "h2": { $0.font(.title) },
        "h3": { $0.font(.headline) },
        "h4": { $0.font(.subheadline) },
        "h5": { $0.font(.callout) },
        "h6": { $0.font(.caption) },
        
        "i": { $0.italic() },
        "u": { $0.underline() },
        "s": { $0.strikethrough() },
        "b": { $0.fontWeight(.bold) },
        
        "sup": { $0.baselineOffset(10).font(.footnote) },
        "sub": { $0.baselineOffset(-10).font(.footnote) }
    ]
    /// Parser formatted text.
    private let text: Text

    /**
     Creates a text view that displays formatted content.
     
     - parameter htmlString: HTML-tagged string.
     - parameter tags: Set of supported tags and associated modifiers for a particular instance.
     */
    public init(_ htmlString: String, tags: Dictionary<String, (Text) -> (Text)>? = nil) {
        let parser = HTML2TextParser(htmlString, availableTags: tags == nil ? AttributedText.tags : tags!)
        parser.parse()
        text = parser.formattedText
    }

    public var body: some View {
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
