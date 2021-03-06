//
//  CharacterListView.swift
//  Marvel
//
//  Created by Gonzalo Diz on 29/10/2021.
//

import Foundation
import UIKit

protocol CharacterListViewDelegate: AnyObject {
    func updateSearchResults(for text: String?)
}

final class CharacterListView: UIView {

    var searchText: String? {
        searchBar.text
    }

    var isLoading: Bool = false {
        didSet {
            placeholderView.isHidden = true
            tableView.tableFooterView?.isHidden = !isLoading
        }
    }

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.cellIdentifier)
        tableView.tableFooterView = loadingFooterView
        tableView.accessibilityIdentifier = A11y.CharacterListView.tableView
        tableView.backgroundView = placeholderView
        tableView.keyboardDismissMode = .onDrag
        tableView.backgroundColor = .systemGray6
        tableView.separatorStyle = .none
        return tableView
    }()

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = self
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = "Search"
        return searchBar
    }()

    weak var delegate: CharacterListViewDelegate?

    private lazy var loadingFooterView: UIView = {
        let contentView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 60))
        let activityIndicator = UIActivityIndicatorView()
        contentView.addSubview(activityIndicator)

        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(contentView)
        }

        activityIndicator.startAnimating()

        contentView.accessibilityIdentifier = A11y.CharacterListView.loadingView

        return contentView
    }()

    private lazy var placeholderView: PlaceholderView = {
        let placeholderView = PlaceholderView(imageName: "sad_deadpool")
        placeholderView.isHidden = true
        return placeholderView
    }()

    init() {
        super.init(frame: .zero)
        backgroundColor = .systemBackground

        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func didScrollToBottom() -> Bool {
        let offsetY = tableView.contentOffset.y
        let height = tableView.contentSize.height
        let buffer: CGFloat = 150.0
        let hasCellsToScroll = !tableView.visibleCells.isEmpty

        return offsetY > (height - tableView.frame.size.height - buffer) && hasCellsToScroll
    }

    func showError(_ message: String) {
        placeholderView.setTitle(message)
        placeholderView.isHidden = false
    }

    private func setupConstraints() {
        addSubview(searchBar)
        addSubview(tableView)

        searchBar.snp.makeConstraints { make in
            make.top.trailing.leading.equalTo(safeAreaLayoutGuide)
        }

        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(searchBar.snp.bottom)
        }
    }

    @objc
    private func updateSearchResults() {
        delegate?.updateSearchResults(for: searchText)
    }
}

// MARK: UISearchBarDelegate

extension CharacterListView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(
            withTarget: self,
            selector: #selector(updateSearchResults),
            object: nil
        )

        perform(#selector(updateSearchResults), with: nil, afterDelay: 0.5)
    }
}
