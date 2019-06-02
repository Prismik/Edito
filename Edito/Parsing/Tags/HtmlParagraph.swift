//
//  HtmlParagraph.swift
//  Edito
//
//  Created by Francis Beauchamp on 2019-05-30.
//  Copyright © 2019 Francis Beauchamp. All rights reserved.
//

import Foundation
import AppKit

internal enum HtmlParagraph: String {
    case p = "p"
    case div = "div"
    case span = "span"

    static var all: [HtmlTag] { return [HtmlParagraph.p, HtmlParagraph.div, HtmlParagraph.span] }
}

extension HtmlParagraph: HtmlTag {
    var supportedAttributes: HtmlAttribute.Type { return HtmlParagraph.Attribute.self }
    var identifier: String { return rawValue }

    var key: NSAttributedString.Key { return .font }
    var value: Any {
        guard let stylesheet = Edito.stylesheet else { return NSFont.systemFont(ofSize: 16) }
        return stylesheet.regularFont
    }
    var dictionary: [NSAttributedString.Key: Any] { return [key: value] }

    enum Attribute: HtmlAttribute {
        case bold
        case italic

        var supportedContexts: [String] {
            switch self {
            case .bold:
                return ["b", "bold", "strong"]
            case .italic:
                return ["i", "em"]
            }
        }

        var key: NSAttributedString.Key { return .font }

        var value: Any {
            switch self {
            case .bold:
                guard let stylesheet = Edito.stylesheet else { return NSFont.boldSystemFont(ofSize: 16) }
                return stylesheet.boldFont
            case .italic:
                guard let stylesheet = Edito.stylesheet else { return NSFont.systemFont(ofSize: 16) }
                return stylesheet.italicFont
            }
        }

        var dictionary: [NSAttributedString.Key: Any] { return [key: value] }
        var modifier: String { return "" }

        static var all: [HtmlAttribute] { return [Attribute.bold, Attribute.italic] }
    }
}
