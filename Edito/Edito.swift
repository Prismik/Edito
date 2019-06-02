//
//  Edito.swift
//  Edito
//
//  Created by Francis Beauchamp on 2019-06-01.
//  Copyright © 2019 Francis Beauchamp. All rights reserved.
//

import Foundation
import AppKit

/// Defines different fonts and sizes for generating NSAttributedString from html
protocol EditoStylesheet {
    static var header1: CGFloat { get }
    static var header2: CGFloat { get }
    static var header3: CGFloat { get }
    static var header4: CGFloat { get }
    static var header5: CGFloat { get }
    static var header6: CGFloat { get }

    static var content: CGFloat { get }

    static var boldFont: NSFont { get }
    static var italicFont: NSFont { get }
    static var regularFont: NSFont { get }
}

class Edito {
    /**
        Changing this with your own implementation of `EditoStylesheet`
        allows you to control how the different fonts will be generated in the [parse](x-source-tag://parse).
    */
    static var stylesheet: EditoStylesheet.Type?

    /**
        Converts an html string into a list of attributed strings which you can use in a UIView
        - Tag: parse
    */
    static func parse(content: String) throws -> [NSAttributedString] {
        let parser = HtmlParser()
        return try parser.parse(content: content.trimmingCharacters(in: .whitespacesAndNewlines))
    }
}
