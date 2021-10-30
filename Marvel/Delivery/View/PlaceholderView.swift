//
//  PlaceholderView.swift
//  Marvel
//
//  Created by Gonzalo Diz on 30/10/2021.
//

import SnapKit
import UIKit

final class PlaceholderView: UIView {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 26, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 0
        label.accessibilityIdentifier = A11y.PlaceholderView.titleLabel
        label.textAlignment = .center
        return label
    }()

    private lazy var imageView = UIImageView()

    private lazy var containerView = UIView()

    init(imageName: String) {
        super.init(frame: .zero)
        imageView.image = UIImage(named: imageName)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setTitle(_ title: String) {
        titleLabel.text = title
    }

    private func setupConstraints() {
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(imageView)

        containerView.snp.makeConstraints { make in
            make.centerX.equalTo(snp.centerX)
            make.centerY.equalTo(snp.centerY)
            make.leading.greaterThanOrEqualTo(safeAreaLayoutGuide.snp.leading).offset(Spacing.medium).priority(999)
            make.trailing.lessThanOrEqualTo(safeAreaLayoutGuide.snp.trailing).offset(-Spacing.medium).priority(999)
        }

        imageView.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(containerView)
            make.height.width.equalTo(300)
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(containerView)
            make.top.equalTo(imageView.snp.bottom).offset(Spacing.small)
        }
    }

}
