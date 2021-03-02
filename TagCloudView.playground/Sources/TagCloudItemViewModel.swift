//
//  TagCloudView.swift
//  SwiftAlyzer
//
//  Copyright © 2021 ProfessionAlyzer UG. All rights reserved.
//

import Foundation

/// Represents content of a tag.
public struct TagCloudItemViewModel {

    /// Title of tag.
    public let title: String

    /// Initializes a new `TagCloudItemViewModel` with given title.
    public init(title: String) {
        self.title = title
    }
}
