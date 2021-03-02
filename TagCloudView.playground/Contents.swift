//
//  TagCloudView.swift
//  SwiftAlyzer
//
//  Copyright © 2021 ProfessionAlyzer UG. All rights reserved.
//

import AppKit
import PlaygroundSupport

// MARK: - Setup of TagCloudView

let tagCloudView = TagCloudView()
let items = ["This", "is", "a", "test"]
    .map(TagCloudItemViewModel.init(title:))
tagCloudView.addItems(items: items)

// MARK: - Example for TagCloudViewDelegate

class Delegate: TagCloudViewDelegate {
    func removeClicked(title: String) {
        print("Clicked remove button on tag \(title)")
    }
}
tagCloudView.delegate = Delegate()

// MARK: - Setup of playground page

let splitViewFrame = NSRect(x: 0, y: 0, width: 300, height: 150)
let splitView = NSSplitView(frame: splitViewFrame)

let leftView = NSView()
leftView.addSubview(tagCloudView)
tagCloudView.translatesAutoresizingMaskIntoConstraints = false
NSLayoutConstraint.activate([
    tagCloudView.topAnchor.constraint(equalTo: leftView.topAnchor),
    tagCloudView.leadingAnchor.constraint(equalTo: leftView.leadingAnchor),
    tagCloudView.trailingAnchor.constraint(equalTo: leftView.trailingAnchor)
])

let rightView = NSView()
rightView.wantsLayer = true
rightView.layer?.backgroundColor = NSColor.lightGray.cgColor

splitView.isVertical = true
splitView.addSubview(leftView)
splitView.addSubview(rightView)
splitView.adjustSubviews()

// Present the view in Playground
PlaygroundPage.current.liveView = splitView
PlaygroundPage.current.needsIndefiniteExecution = true
