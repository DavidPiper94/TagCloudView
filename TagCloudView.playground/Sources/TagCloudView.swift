//
//  TagCloudView.swift
//  SwiftAlyzer
//
//  Copyright © 2021 ProfessionAlyzer UG. All rights reserved.
//

import AppKit

public class TagCloudView: NSView {

    // MARK: - Public Properties

    /// Delegate to handle interactions on a `TagCloudItemView`.
    public var delegate: TagCloudViewDelegate? {
        didSet {
            itemViews.forEach {
                $0.delegate = delegate
            }
        }
    }

    // MARK: - Private Properties

    private var itemViews = [TagCloudItemView]()
    private var rows = [NSStackView]()
    private lazy var rowStackView: NSStackView = {
        let stackView = NSStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.orientation = .vertical
        stackView.spacing = 0.0
        return stackView
    }()
    private var emptyRowStackView: NSStackView {
        let emptyRowStackView = NSStackView()
        emptyRowStackView.orientation = .horizontal
        emptyRowStackView.distribution = .fillProportionally
        emptyRowStackView.spacing = 0.0
        return emptyRowStackView
    }
    private var timer: Timer?

    // MARK: - Lifecycle

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    public override func viewWillStartLiveResize() {
        super.viewWillStartLiveResize()
        startTimer()
    }

    public override func viewDidEndLiveResize() {
        super.viewDidEndLiveResize()
        timer?.invalidate()
        buildRows()
    }

    // MARK: - Public Methods

    /// Adds the single given item and updates the cloud view.
    public func addItem(item: TagCloudItemViewModel) {
        let newItemView = TagCloudItemView(frame: .zero, viewModel: item)
        newItemView.delegate = delegate
        itemViews.append(newItemView)
        buildRows()
    }

    /// Adds all given items and updates the cloud view.
    public func addItems(items: [TagCloudItemViewModel]) {
        let newItemViews = items.map { (item: TagCloudItemViewModel) -> TagCloudItemView in
            let newItemView = TagCloudItemView(frame: .zero, viewModel: item)
            newItemView.delegate = delegate
            return newItemView
        }
        itemViews.append(contentsOf: newItemViews)
        buildRows()
    }

    // MARK: - Private Methods

    private func setupUI() {
        addSubview(rowStackView)
        NSLayoutConstraint.activate([
            rowStackView.topAnchor.constraint(equalTo: topAnchor),
            rowStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            rowStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            rowStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    private func startTimer() {
        let repeatedTimer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { _ in
            self.buildRows()
        }
        timer = repeatedTimer
        RunLoop.main.add(repeatedTimer, forMode: .common)
    }

    @objc private func buildRows() {
        clearRows()
        setupRows()
        showRows()
    }

    private func clearRows() {
        for row in rows {
            rowStackView.removeArrangedSubview(row)
            row.removeFromSuperview()
        }
        rows = [emptyRowStackView]
    }

    private func setupRows() {
        for item in itemViews {
            guard let currentRow = rows.last else { return }
            // Calculate width of current row and check, if current item fits
            let previousItemWidthInCurrentRow = currentRow.arrangedSubviews
                .map(\.frame.width)
                .reduce(0, +)
            if frame.width > previousItemWidthInCurrentRow + item.expectedWidth {
                currentRow.addArrangedSubview(item)
            } else {
                // Add empty view to align previous row to the left.
                let fillerView = NSView()
                currentRow.addArrangedSubview(fillerView)
                // Start next row.
                let newRowStackView = emptyRowStackView
                newRowStackView.addArrangedSubview(item)
                rows.append(newRowStackView)
            }
        }
        // Add empty view to align last row to the left.
        let fillerView = NSView()
        rows.last?.addArrangedSubview(fillerView)
    }

    private func showRows() {
        for row in rows {
            rowStackView.addArrangedSubview(row)
        }
    }
}
