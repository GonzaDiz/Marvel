//
//  CharacterListView.swift
//  Marvel
//
//  Created by Gonzalo Diz on 29/10/2021.
//

import Foundation
import UIKit

final class CharacterListView: UIView {
    private lazy var loadingFooterView: UIView = {
        let contentView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 60))

        let activityIndicator = UIActivityIndicatorView()
        contentView.addSubview(activityIndicator)

        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(contentView)
        }

        activityIndicator.startAnimating()

        return contentView
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.cellIdentifier)
        tableView.tableFooterView = loadingFooterView
        return tableView
    }()

    init() {
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func hideLoadingView(_ isLoading: Bool) {
        tableView.tableFooterView?.isHidden = !isLoading
    }

    func didScrollToBottom() -> Bool {
        let offsetY = tableView.contentOffset.y
        let height = tableView.contentSize.height
        let buffer = 150.0

        return offsetY > (height - tableView.frame.size.height - buffer)
    }

    private func setupConstraints() {
        addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalTo(self)
        }
    }
}
