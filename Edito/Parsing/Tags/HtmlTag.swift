//
//  Tag.swift
//  Edito
//
//  Created by Francis Beauchamp on 2019-05-30.
//  Copyright © 2019 Francis Beauchamp. All rights reserved.
//

import Foundation

protocol HtmlTag {
    /// String value of a tag
    var identifier: String { get }

    /// The nested tags that can be used in this tag's context to style part of the content.
    var supportedAttributes: HtmlAttribute.Type { get }

    var key: NSAttributedString.Key { get }
    var value: Any { get }
    var dictionary: [NSAttributedString.Key: Any] { get }

    static var all: [HtmlTag] { get }

    func didFindTag()
    func equals(tag: HtmlTag) -> Bool
}

extension HtmlTag {
    func didFindTag() {
        // No-op by default
    }

    func equals(tag: HtmlTag) -> Bool {
        return identifier == tag.identifier
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
