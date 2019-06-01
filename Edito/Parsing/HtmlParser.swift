//
//  HtmlParser.swift
//  Edito
//
//  Created by Francis Beauchamp on 2019-05-30.
//  Copyright © 2019 Francis Beauchamp. All rights reserved.
//

import Foundation

public class HtmlParser {
    static func parse(content: String) {
        // TODO identify the main tags and create the specific HTMLTag object to parse them
        //      return a list of configured UIView
    }

    static func parse(content: String, as tag: HtmlTag) -> NSAttributedString {
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
            attributedString.append(NSAttributedString(string: currentString))
        }

        return attributedString
    }

//    public static func computeViews(for htmlString: String) -> [UIView] {
//        var mutableString = htmlString
//        var views: [UIView] = []
//        while !mutableString.isEmpty, let tag = nextTag(in: &mutableString) {
//            print(tag.content)
//            print(tag.contentType)
//            if let view = tag.computeView() {
//                views.append(view)
//            }
//        }
//
//        return views
//    }

//    private static func nextTag(in string: inout String) -> HtmlTags? {
//        guard let tagStartIndex = string.firstIndex(of: "<") else {
//            print("tagStartIndex < not found")
//            return nil
//        }
//
//        string = String(string[tagStartIndex...])
//        guard let tagEndIndex = string.firstIndex(of: ">") else {
//            print("tagEndIndex > not found")
//            return nil
//        }
//
//        let innerTag = string[string.index(after: tagStartIndex)..<tagEndIndex]
//        string = String(string[string.index(after: tagEndIndex)...])
//
//
//        guard let contenType = HtmlTags.ContentType(rawValue: String(innerTag)) else { return nil }
//        guard let closingTagStartIndex = string.firstIndex(of: "<") else { return nil }
//
//        let content = string[..<closingTagStartIndex]
//        string = String(string[string.index(after: closingTagStartIndex)...])
//        guard let closingTagEndIndex = string.firstIndex(of: ">") else { return nil }
//        string = String(string[string.index(after: closingTagEndIndex)...])
//        return HtmlTags(type: contenType, content: String(content))
//    }
}
