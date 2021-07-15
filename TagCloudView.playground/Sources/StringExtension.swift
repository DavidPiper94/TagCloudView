//
//  StringExtension.swift
//  SwiftAlyzer
//
//  Copyright © 2021 ProfessionAlyzer UG. All rights reserved.
//

import AppKit

extension String {

    /// Calculates width of this string.
    /// - Parameter font: The font used to display the string.
    /// - Returns: The estimated width of this string.
    public func widthOfString(usingFont font: NSFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}
