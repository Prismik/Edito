//
//  HtmlList.swift
//  Edito
//
//  Created by Francis Beauchamp on 2019-05-30.
//  Copyright © 2019 Francis Beauchamp. All rights reserved.
//

import Foundation
import AppKit

internal enum HtmlList: String {
    case ul = "ul"
    case ol = "ol"

    static var all: [HtmlTag] { return [HtmlList.ul, HtmlList.ol] }
}

extension HtmlList: HtmlTag {
    var supportedAttributes: HtmlAttribute.Type {
        switch self {
        case .ol:
            return OrderedListAttribute.self
        case .ul:
            return UnorderedListAttribute.self
        }
    }

    var identifier: String { return rawValue }

    var key: NSAttributedString.Key { return .font }
    var value: Any {
        guard let stylesheet = Edito.stylesheet else { return NSFont.systemFont(ofSize: 16) }
        return stylesheet.regularFont
    }
    var dictionary: [NSAttributedString.Key: Any] { return [key: value] }


    enum OrderedListAttribute: HtmlAttribute {
        case item

        static var count = 0

        var supportedContexts: [String] { return ["li"] }
        var key: NSAttributedString.Key { return .font }
        var value: Any { return NSFont.systemFont(ofSize: 16) }
        var modifier: String {
            return "\n\(OrderedListAttribute.count + 1)  "
        }
        var dictionary: [NSAttributedString.Key: Any] { return [key: value] }

        static var all: [HtmlAttribute] { return [OrderedListAttribute.item] }
    }

    enum UnorderedListAttribute: HtmlAttribute {
        case item

        var supportedContexts: [String] { return ["li"] }
        var key: NSAttributedString.Key { return .font }
        var value: Any {
            guard let stylesheet = Edito.stylesheet else { return NSFont.systemFont(ofSize: 16) }
            return stylesheet.regularFont
        }
        var modifier: String {
            return "\n•  "
        }
        var dictionary: [NSAttributedString.Key: Any] { return [key: value] }

        static var all: [HtmlAttribute] { return [UnorderedListAttribute.item] }
    }


    func didFindTag() {
        switch self {
        case .ol:
            OrderedListAttribute.count += 1
        case .ul:
            break
        }
    }
}
