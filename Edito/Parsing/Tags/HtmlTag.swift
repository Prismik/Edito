//
//  Tag.swift
//  Edito
//
//  Created by Francis Beauchamp on 2019-05-30.
//  Copyright © 2019 Francis Beauchamp. All rights reserved.
//

import Foundation

protocol HtmlTag {
    var openingContext: String { get }
    var closingContext: String? { get }
    var supportedAttributes: HtmlAttribute.Type { get }
    static var all: [HtmlTag] { get }

    func didFindTag()
}

extension HtmlTag {
    func didFindTag() {
        // No-op by default
    }

    func attributedString(from content: String) -> NSAttributedString {
        HtmlList.OrderedListAttribute.count = 0
        return HtmlParser.parse(content: content, as: self)
    }
}

protocol HtmlAttribute {
    var supportedContexts: [String] { get }
    var key: NSAttributedString.Key { get }
    var value: Any { get }
    var dictionary: [NSAttributedString.Key: Any] { get }
    var modifier: String { get }

    static func context(string: String) -> HtmlAttribute?
    static var all: [HtmlAttribute] { get }
}

extension HtmlAttribute {
    static func context(string: String) -> HtmlAttribute? {
        return all.first(where: { (attribute) -> Bool in
            attribute.supportedContexts.contains(string)
        })
    }
}
