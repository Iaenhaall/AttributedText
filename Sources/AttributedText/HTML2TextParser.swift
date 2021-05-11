//
//  HTML2TextParser.swift
//
//
//  Created by Никита Белокриницкий on 11.03.2021.
//

import SwiftUI

/**
 Parser for converting HTML-tagged text to SwiftUI Text View.
 
 - warning: **Only single-word tags are supported**. Tags with more than one word or
 containing any characters besides **letters** or **numbers** are ignored and not removed.
 
 # Notes:
 1. Handles unopened/unclosed tags.
 2. Deletes tags that have no modifiers.
 3. Does **not** handle HTML characters, for example `&lt;`.
 */
internal class HTML2TextParser {
    /// The result of the parser's work.
    internal private(set) var formattedText = Text("")
    /// HTML-tagged text.
    private let htmlString: String
    /// Set of currently active tags.
    private var tags: Set<String> = []
    /// Set of supported tags and associated modifiers.
    private let availableTags: Dictionary<String, (Text) -> (Text)>

    /**
     Creates a new parser instance.
     
     - parameter htmlString: HTML-tagged string.
     - parameter availableTags: Set of supported tags and associated modifiers.
     */
    internal init(_ htmlString: String, availableTags: Dictionary<String, (Text) -> (Text)>) {
        self.htmlString = htmlString
        self.availableTags = availableTags
    }

    /// Starts the text parsing process. The results of this method will be placed in the `formattedText` variable.
    internal func parse() {
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
                if htmlString[index].isLetter || htmlString[index].isHexDigit {
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
