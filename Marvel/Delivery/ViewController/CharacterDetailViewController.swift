//
//  CharacterDetailViewController.swift
//  Marvel
//
//  Created by Gonzalo Diz on 29/10/2021.
//

import UIKit
import RxSwift
import RxDataSources

final class CharacterDetailViewController: UIViewController {
    private let viewModel: CharacterDetailViewModel
    private let disposeBag = DisposeBag()

    private lazy var tableView = UITableView()

    private let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Item>>(
        configureCell: { (_, tableView, _, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.cellIdentifier) ?? UITableViewCell()
            cell.textLabel?.text = element.name
            return cell
        },
        titleForHeaderInSection: { dataSource, sectionIndex in
            return dataSource[sectionIndex].model
        }
    )

    init(viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupConstraints()
        setupBindings()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if let headerView = tableView.tableHeaderView {
            layoutMarginView(headerView)
            tableView.tableHeaderView = headerView
        }
    }

    private func setupConstraints() {
        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
    }

    private func setupBindings() {
        disposeBag.insert(
            viewModel.title.observe(
                on: MainScheduler.instance
            ).bind(onNext: { [weak self] title in
                self?.title = title
            }),
            viewModel.sections.observe(
                on: MainScheduler.instance
            ).bind(
                to: tableView.rx.items(
                    dataSource: dataSource
                )
            ),
            viewModel.header.observe(
                on: MainScheduler.instance
            ).bind(onNext: { [weak self] headerItems in
                        let headerView = CharacterDetailHeaderView(
                            imageURL: headerItems.imageURL,
                            description: headerItems.description
                        )
                        self?.tableView.tableHeaderView = headerView
                    }
                  )
        )
    }

    private func layoutMarginView(_ marginView: UIView) {
        marginView.frame.size.width = view.bounds.size.width
        marginView.setNeedsLayout()
        marginView.layoutIfNeeded()

        let height = marginView.systemLayoutSizeFitting(
            CGSize(
                width: view.bounds.size.width,
                height: UIView.layoutFittingCompressedSize.height
            )
        ).height
        marginView.frame.size.height = height
    }
}
