//
//  main.swift
//  Edito
//
//  Created by Francis Beauchamp on 2019-05-30.
//  Copyright © 2019 Francis Beauchamp. All rights reserved.
//

import Foundation


let contentString = "This is <b>Bold</b> content and <i>italic</i> content."
print(HtmlParser.parse(content: contentString, as: HtmlParagraph.p))

let listString = "<li>A list item</li>\n<li>Another list item</li>\n<li>Last list item</li>"
print(HtmlParser.parse(content: listString, as: HtmlList.ul))
print(HtmlParser.parse(content: listString, as: HtmlList.ol))

