//
//  CharacterDetailViewController.swift
//  Marvel
//
//  Created by Gonzalo Diz on 29/10/2021.
//

import UIKit
import RxSwift

final class CharacterDetailViewController: UIViewController {
    private let viewModel: CharacterDetailViewModel
    private let disposeBag = DisposeBag()

    init(viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .red
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }

    private func setupBindings() {
        disposeBag.insert(
            viewModel.title.bind(onNext: { [weak self] title in
                self?.title = title
            })
        )
    }
}
