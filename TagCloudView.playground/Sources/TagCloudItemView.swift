//
//  TagCloudItemView.swift
//  SwiftAlyzer
//
//  Copyright © 2021 ProfessionAlyzer UG. All rights reserved.
//

import Cocoa

public class TagCloudItemView: NSView {

    // MARK: - Public Properties

    /// Delegate to handle interactions on this view.
    public var delegate: TagCloudViewDelegate?

    /// Expected width of this view. Used to calculate row in `TagCloudView`.
    public var expectedWidth: CGFloat {
        let font = NSFont.labelFont(ofSize: 13)
        let titleWidth = viewModel.title.widthOfString(usingFont: font)
        let buttonAndSpacingWidth = CGFloat(40)
        return titleWidth + buttonAndSpacingWidth
    }

    // MARK: - Private Properties

    private lazy var backgroundView: NSView = {
        let view = NSView()
        view.wantsLayer = true
        view.layer?.masksToBounds = true
        view.layer?.backgroundColor = NSColor.darkGray.cgColor
        view.layer?.cornerRadius = 8.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var titleLabel: NSTextField = {
        let label = NSTextField()
        label.textColor = .black
        label.isEditable = false
        label.isBordered = false
        label.drawsBackground = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    private lazy var removeButton: NSButton = {
        let button = NSButton()
        button.title = "x"
        button.contentTintColor = .black
        button.isBordered = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.target = self
        button.action = #selector(removeButtonPressed)
        return button
    }()

    private var viewModel: TagCloudItemViewModel

    // MARK: - Lifecycle

    public init(
        frame frameRect: NSRect,
        viewModel: TagCloudItemViewModel
    ) {
        self.viewModel = viewModel
        super.init(frame: frameRect)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    private func setupUI() {
        for view in [backgroundView, titleLabel, removeButton] {
            addSubview(view)
        }

        titleLabel.stringValue = viewModel.title

        NSLayoutConstraint.activate([
            backgroundView.centerXAnchor.constraint(equalTo: centerXAnchor),
            backgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),

            titleLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 4),
            titleLabel.trailingAnchor.constraint(equalTo: removeButton.leadingAnchor,constant: -4),
            titleLabel.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),

            removeButton.topAnchor.constraint(greaterThanOrEqualTo: backgroundView.topAnchor, constant: 4),
            removeButton.bottomAnchor.constraint(greaterThanOrEqualTo: backgroundView.bottomAnchor, constant: -4),
            removeButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor,constant: -4),
            removeButton.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            removeButton.heightAnchor.constraint(equalToConstant: 20),
            removeButton.widthAnchor.constraint(equalToConstant: 20)
        ])
    }

    @objc private func removeButtonPressed(_ sender: NSButton) {
        delegate?.removeClicked(title: viewModel.title)
    }
}
