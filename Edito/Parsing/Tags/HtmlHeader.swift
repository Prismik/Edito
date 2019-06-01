//
//  HtmlHeader.swift
//  Edito
//
//  Created by Francis Beauchamp on 2019-05-31.
//  Copyright © 2019 Francis Beauchamp. All rights reserved.
//

import Foundation
import AppKit

enum HtmlHeader: String {
    case h1 = "h1"
    case h2 = "h2"
    case h3 = "h3"
    case h4 = "h4"
    case h5 = "h5"
    case h6 = "h6"

    static var all: [HtmlTag] {
        return [HtmlHeader.h1, HtmlHeader.h2, HtmlHeader.h3, HtmlHeader.h4, HtmlHeader.h5, HtmlHeader.h6]
    }
}

extension HtmlHeader: HtmlTag {
    var supportedAttributes: HtmlAttribute.Type { return HtmlHeader.Attribute.self }
    var openingContext: String { return "<\(rawValue)>" }
    var closingContext: String? { return "</\(rawValue)>" }

    enum Attribute: HtmlAttribute {
        case italic

        var supportedContexts: [String] { return ["i", "em"] }
        var key: NSAttributedString.Key { return .font }
        var value: Any { return NSFont.systemFont(ofSize: 16) }
        var dictionary: [NSAttributedString.Key : Any] { return [key: value] }
        var modifier: String { return "" }

        static var all: [HtmlAttribute] { return [Attribute.italic] }
    }
}
