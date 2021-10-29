//
//  CharacterListViewController.swift
//  Marvel
//
//  Created by Gonzalo Diz on 28/10/2021.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

final class CharacterListViewController: UIViewController {
    private let viewModel: CharacterListViewModel
    private let disposeBag = DisposeBag()
    private let reuseIdentifier = "UITableViewCell"
    private let didSelectCharacter: (Character) -> Void

    private lazy var loadingFooterView: UIView = {
        let contentView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60))

        let activityIndicator = UIActivityIndicatorView()
        contentView.addSubview(activityIndicator)

        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(contentView)
        }

        activityIndicator.startAnimating()

        return contentView
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = loadingFooterView
        return tableView
    }()

    init(viewModel: CharacterListViewModel, didSelectCharacter: @escaping (Character) -> Void) {
        self.viewModel = viewModel
        self.didSelectCharacter = didSelectCharacter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Marvel Characters"
        view.backgroundColor = .systemBackground
        setupConstraints()
        setupBindings()
        viewModel.listCharacters()
    }

    private func setupConstraints() {
        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func setupBindings() {
        disposeBag.insert(
            viewModel.characters.bind(
                to: tableView.rx.items(
                    cellIdentifier: reuseIdentifier,
                    cellType: UITableViewCell.self
                )
            ) { (_, item, cell) in
                cell.textLabel?.text = item.name
            },
            viewModel.isLoading.subscribe { [weak self] isLoading in
                self?.tableView.tableFooterView?.isHidden = !isLoading
            },
            tableView.rx.didScroll.subscribe { [weak self] _ in
                guard let self = self else { return }
                if self.didScrollToBottom() {
                    self.viewModel.listCharacters()
                }
            },
            tableView.rx.modelSelected(Character.self).subscribe(onNext: { [weak self] character in
                self?.didSelectCharacter(character)
            })
        )
    }

    private func didScrollToBottom() -> Bool {
        let offsetY = tableView.contentOffset.y
        let height = tableView.contentSize.height
        let buffer = 150.0

        return offsetY > (height - tableView.frame.size.height - buffer)

    }
}
