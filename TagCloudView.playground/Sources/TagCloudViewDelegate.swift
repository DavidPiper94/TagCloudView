//
//  TagCloudView.swift
//  SwiftAlyzer
//
//  Copyright © 2021 ProfessionAlyzer UG. All rights reserved.
//

import Foundation

/// Delegate to handle interactions on `TagCloudView`.
public protocol TagCloudViewDelegate {

    /// Informs delegate about click on remove button of tag with given title.
    /// - Parameter title: The title of the tag for which the close button was pressed.
    func removeClicked(title: String)
}
