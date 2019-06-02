//
//  EditoStylesheet.swift
//  Edito
//
//  Created by Francis Beauchamp on 2019-06-02.
//  Copyright © 2019 Francis Beauchamp. All rights reserved.
//

import AppKit

/// Defines different fonts and sizes for generating NSAttributedString from html
public protocol EditoStylesheet {
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
