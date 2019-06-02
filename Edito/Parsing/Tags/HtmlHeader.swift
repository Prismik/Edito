//
//  HtmlHeader.swift
//  Edito
//
//  Created by Francis Beauchamp on 2019-05-31.
//  Copyright © 2019 Francis Beauchamp. All rights reserved.
//

import Foundation
import AppKit

internal enum HtmlHeader: String {
    case h1 = "h1"
    case h2 = "h2"
    case h3 = "h3"
    case h4 = "h4"
    case h5 = "h5"
    case h6 = "h6"

    static var all: [HtmlTag] {
        return [HtmlHeader.h1, HtmlHeader.h2, HtmlHeader.h3, HtmlHeader.h4, HtmlHeader.h5, HtmlHeader.h6]
    }

    private var fontSize: CGFloat {
        guard let stylesheet = Edito.stylesheet else { return 20 }
        switch self {
        case .h1:
            return stylesheet.header1
        case .h2:
            return stylesheet.header2
        case .h3:
            return stylesheet.header3
        case .h4:
            return stylesheet.header4
        case .h5:
            return stylesheet.header5
        case .h6:
            return stylesheet.header6
        }
    }
}

extension HtmlHeader: HtmlTag {
    var supportedAttributes: HtmlAttribute.Type { return HtmlHeader.Attribute.self }
    var identifier: String { return rawValue }

    var key: NSAttributedString.Key { return .font }
    var value: Any {
        guard let stylesheet = Edito.stylesheet else { return NSFont.boldSystemFont(ofSize: fontSize) }
        guard let font = NSFont(name: stylesheet.boldFont.fontName, size: fontSize) else {
            return NSFont.boldSystemFont(ofSize: fontSize)
        }

        return font
    }
    var dictionary: [NSAttributedString.Key: Any] { return [key: value] }

    enum Attribute: HtmlAttribute {
        case italic

        var supportedContexts: [String] { return ["i", "em"] }
        var key: NSAttributedString.Key { return .font }
        var value: Any {
            guard let stylesheet = Edito.stylesheet else { return NSFont.systemFont(ofSize: 16) }
            return stylesheet.italicFont // TODO Bold + italic
        }
        var dictionary: [NSAttributedString.Key : Any] { return [key: value] }
        var modifier: String { return "" }

        static var all: [HtmlAttribute] { return [Attribute.italic] }
    }
}
