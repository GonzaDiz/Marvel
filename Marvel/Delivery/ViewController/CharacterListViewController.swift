//
//  CharacterListViewController.swift
//  Marvel
//
//  Created by Gonzalo Diz on 28/10/2021.
//

import UIKit

final class CharacterListViewController: UIViewController {
    private let viewModel: CharacterListViewModel

    init(viewModel: CharacterListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}
