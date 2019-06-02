//
//  Edito.swift
//  Edito
//
//  Created by Francis Beauchamp on 2019-06-01.
//  Copyright © 2019 Francis Beauchamp. All rights reserved.
//

import Foundation
import AppKit

public class Edito {
    /**
        Changing this with your own implementation of `EditoStylesheet`
        allows you to control how the different fonts will be generated in the [parse](x-source-tag://parse).
    */
    public static var stylesheet: EditoStylesheet.Type?

    /**
        Converts an html string into a list of attributed strings which you can use in a UIView
        - Tag: parse
    */
    public static func parse(content: String) throws -> [NSAttributedString] {
        let parser = HtmlParser()
        return try parser.parse(content: content.trimmingCharacters(in: .whitespacesAndNewlines))
    }
}
