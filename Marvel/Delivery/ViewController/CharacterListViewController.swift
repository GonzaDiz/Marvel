//
//  CharacterListViewController.swift
//  Marvel
//
//  Created by Gonzalo Diz on 28/10/2021.
//

import AlamofireImage
import UIKit
import RxCocoa
import RxSwift
import SnapKit

final class CharacterListViewController: UIViewController {
    private let viewModel: CharacterListViewModel
    private let disposeBag = DisposeBag()
    private let didSelectCharacter: (Character) -> Void

    private lazy var ui = CharacterListView()

    init(viewModel: CharacterListViewModel, didSelectCharacter: @escaping (Character) -> Void) {
        self.viewModel = viewModel
        self.didSelectCharacter = didSelectCharacter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = ui
        ui.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Marvel Characters"
        setupBindings()
        viewModel.listCharacters(filteredBy: ui.searchText)
    }

    private func setupBindings() {
        disposeBag.insert(
            ui.tableView.rx.setDelegate(self),
            viewModel.characters.bind(
                to: ui.tableView.rx.items(
                    cellIdentifier: CharacterTableViewCell.cellIdentifier,
                    cellType: CharacterTableViewCell.self
                )
            ) { (_, item, cell) in
                cell.setup(name: item.name, imageURL: item.thumbnail?.url)
            },
            viewModel.isLoading.bind { [weak self] isLoading in
                self?.ui.hideError()
                self?.ui.hideLoadingView(isLoading)
            },
            viewModel.error.skip(1).bind { [weak self] errorMessage in
                self?.ui.showError(errorMessage)
            },
            ui.tableView.rx.didScroll.subscribe { [weak self] _ in
                guard let self = self else { return }
                if self.ui.didScrollToBottom() {
                    self.viewModel.listCharacters(filteredBy: self.ui.searchText)
                }
            },
            ui.tableView.rx.modelSelected(Character.self).bind(onNext: { [weak self] character in
                self?.didSelectCharacter(character)
            })
        )
    }
}

// MARK: UITableViewDelegate

extension CharacterListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ui.tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: CharacterListViewDelegate

extension CharacterListViewController: CharacterListViewDelegate {
    func updateSearchResults(for text: String?) {
        viewModel.searchCharacters(filteredBy: text)
    }
}
