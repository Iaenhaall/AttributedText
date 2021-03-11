//
//  HTML2TextParser.swift
//  AttributedText
//
//  Created by Никита Белокриницкий on 11.03.2021.
//

import SwiftUI

/**
 Parser for converting HTML-tagged text to SwiftUI Text View.
 
 - warning: Only single-word tags are supported. Tags with more than one word or
 containing any characters besides letters are ignored and not deleted.
 
 # Notes: #
 1. Handles unopened/unclosed tags.
 2. Deletes tags that have no modifiers.
 3. Does **not** handle HTML characters, for example `&lt;`.
 */
public class HTML2TextParser {
    /// The result of the parser's work.
    private(set) var formattedText = Text("")
    /// HTML-tagged text.
    private let htmlString: String
    /// Set of currently active tags.
    private var tags: Set<String> = []
    /// Set of supported tags and associated modifiers.
    private let availableTags: Dictionary<String, (Text) -> (Text)> = [
        // This modifier set is presented just for reference.
        // Set the necessary attributes and modifiers for your needs before use.
        "i": { $0.italic() },
        "u": { $0.underline() },
        "s": { $0.strikethrough() },
        "b": { $0.fontWeight(.bold) },
        "sup": { $0.baselineOffset(5).font(.callout) },
        "sub": { $0.baselineOffset(-5).font(.callout) }
    ]

    /**
     Creates a new parser instance.
     
     - parameter htmlString: HTML-tagged string.
     */
    init(_ htmlString: String) {
        self.htmlString = htmlString
    }

    /// Starts the text parsing process. The results of this method will be placed in the `formattedText` variable.
    public func parse() {
        var tag: String? = nil
        var endTag: Bool = false
        var startIndex = htmlString.startIndex
        var endIndex = htmlString.startIndex

        for index in htmlString.indices {
            switch htmlString[index] {
            case "<":
                tag = String()
                endIndex = index
                continue

            case "/":
                if index != htmlString.startIndex && htmlString[htmlString.index(before: index)] == "<" {
                    endTag = true
                } else {
                    tag = nil
                }
                continue

            case ">":
                if let tag = tag {
                    addChunkOfText(String(htmlString[startIndex..<endIndex]))
                    if endTag {
                        tags.remove(tag.lowercased())
                        endTag = false
                    } else {
                        tags.insert(tag.lowercased())
                    }
                    startIndex = htmlString.index(after: index)
                }
                tag = nil
                continue

            default:
                break
            }

            if tag != nil {
                if htmlString[index].isLetter {
                    tag?.append(htmlString[index])
                } else {
                    tag = nil
                }
            }
        }

        endIndex = htmlString.endIndex
        if startIndex != endIndex {
            addChunkOfText(String(htmlString[startIndex..<endIndex]))
        }
    }

    private func addChunkOfText(_ string: String) {
        guard !string.isEmpty else { return }
        var textChunk = Text(string)

        for tag in tags {
            if let action = availableTags[tag] {
                textChunk = action(textChunk)
            }
        }

        formattedText = formattedText + textChunk
    }
}
