//
//  HtmlParser.swift
//  Edito
//
//  Created by Francis Beauchamp on 2019-05-30.
//  Copyright © 2019 Francis Beauchamp. All rights reserved.
//

import Foundation
import AppKit

public class HtmlParser {
    enum HtmlError: Error {
        /// Error occuring when html is malformed.
        case invalidSyntax(String)
    }

    private func tag(from content: String) -> HtmlTag? {
        return
            HtmlParagraph(rawValue: content) ??
            HtmlList(rawValue: content) ??
            HtmlHeader(rawValue: content)
    }

    private var stack: [HtmlTag] = []
    private static let tagStart: Character = "<"
    private static let tagClose: Character = ">"
    private static let endTagDelimiter: Character = "/"

    private typealias TagContext = (inTag: Bool, closing: Bool, inTagContent: Bool)

    internal func parse(content: String) throws -> [NSAttributedString] {
        var attributedStrings: [NSAttributedString] = []
        var subcontentString = ""
        var tagString = ""
        var context: TagContext = (inTag: false, closing: false, inTagContent: false)
        for char in content {
            if char == HtmlParser.endTagDelimiter {
                context = (inTag: true, closing: true, inTagContent: false)
            } else if char == HtmlParser.tagClose {
                guard let tag = tag(from: tagString) else {
                    subcontentString += context.closing ? "</\(tagString)>" : "<\(tagString)>"
                    context = (inTag: false, closing: false, inTagContent: true)
                    tagString.removeAll()
                    continue
                }

                if !context.closing {
                    stack.append(tag)
                } else {
                    let matchingTag = stack.removeLast()
                    if tag.equals(tag: matchingTag) {
                        attributedStrings.append(tag.attributedString(from: subcontentString))
                        subcontentString.removeAll()
                    } else {
                        throw HtmlError.invalidSyntax("Non matching tag found for \(matchingTag.identifier)")
                    }
                }

                context = (inTag: false, closing: false, inTagContent: true)
                tagString.removeAll()
            } else if char == HtmlParser.tagStart {
                context = (inTag: true, closing: false, inTagContent: false)
            } else if context.inTag {
                tagString.append(char)
            } else {
                subcontentString.append(char)
            }
        }

        return attributedStrings
    }

    internal static func parse(content: String, as tag: HtmlTag) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: "")
        var currentString = ""
        var inTag = false
        var inClosingTag = false
        var attribute: HtmlAttribute?
        for char in content {
            if char == "/" {
                inClosingTag = true
                continue
            }

            if inTag && char == ">" {
                if !inClosingTag {
                    attribute = tag.supportedAttributes.context(string: currentString)
                }

                currentString.removeAll()
                inTag = false
                inClosingTag = false
                continue
            }

            if char == "<" {
                if let currentAttribute = attribute {
                    attributedString.append(NSAttributedString(string: "\(currentAttribute.modifier)\(currentString)",
                        attributes: currentAttribute.dictionary))
                    tag.didFindTag()
                    attribute = nil
                    currentString.removeAll()
                } else {
                    if !currentString.isEmpty {
                        attributedString.append(NSAttributedString(string: currentString))
                    }

                    currentString.removeAll()
                }

                inTag = true
                continue
            }

            currentString.append(char)
        }

        if !currentString.isEmpty {
            attributedString.append(NSAttributedString(string: currentString,
                                                       attributes: tag.dictionary))
        }

        return attributedString
    }
}
