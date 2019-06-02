//
//  main.swift
//  Edito
//
//  Created by Francis Beauchamp on 2019-05-30.
//  Copyright © 2019 Francis Beauchamp. All rights reserved.
//

import Foundation

let fullString =
    """
    <ol><li>A list item</li>\n<li>Another list item</li>\n<li>Last list item</li></ol>
    <p>First <em>chunk</em> of text</p>
    <p>This is <b>Bold</b> content and <i>italic</i> content.</p>
    """
if let strings = try? Edito.parse(content: fullString) {
    print(strings)
}
