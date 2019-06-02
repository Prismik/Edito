//
//  main.swift
//  Edito
//
//  Created by Francis Beauchamp on 2019-05-30.
//  Copyright © 2019 Francis Beauchamp. All rights reserved.
//

import Foundation
import AppKit

class MyStylesheet: EditoStylesheet {
    static var header1: CGFloat { return 28 }
    static var header2: CGFloat { return 26 }
    static var header3: CGFloat { return 24 }
    static var header4: CGFloat { return 22 }
    static var header5: CGFloat { return 20 }
    static var header6: CGFloat { return 18 }

    static var content: CGFloat { return 16 }

    static var boldFont: NSFont { return NSFont.boldSystemFont(ofSize: content) }
    static var italicFont: NSFont {
        return NSFontManager.shared.convert(NSFont.systemFont(ofSize: content),
                                            toHaveTrait: NSFontTraitMask.italicFontMask)
    }
    static var regularFont: NSFont { return NSFont.systemFont(ofSize: content) }
}

let fullString =
    """
    <h1>Primary header</h1>
    <ol><li>A list item</li>\n<li>Another list item</li>\n<li>Last list item</li></ol>
    <h2>Secondary header</h2>
    <p>First <em>chunk</em> of text</p>
    <h3>Tertiary header</h3>
    <p>This is <b>Bold</b> content and <i>italic</i> content.</p>
    """
Edito.stylesheet = MyStylesheet.self
if let strings = try? Edito.parse(content: fullString) {
    print(strings)
}


