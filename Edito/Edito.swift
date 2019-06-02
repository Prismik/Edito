//
//  Edito.swift
//  Edito
//
//  Created by Francis Beauchamp on 2019-06-01.
//  Copyright © 2019 Francis Beauchamp. All rights reserved.
//

import Foundation

class Edito {
    static func parse(content: String) throws -> [NSAttributedString] {
        let parser = HtmlParser()
        return try parser.parse(content: content.trimmingCharacters(in: .whitespacesAndNewlines))
    }
}
