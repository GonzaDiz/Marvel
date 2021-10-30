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
        label.font = .preferredFont(forTextStyle: .title2, compatibleWith: .none)
        label.textColor = .label
        label.numberOfLines = 0
        label.accessibilityIdentifier = A11y.PlaceholderView.titleLabel
        label.textAlignment = .center
        return label
    }()

    init() {
        super.init(frame: .zero)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setTitle(_ title: String) {
        titleLabel.text = title
    }

    private func setupConstraints() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.center.equalTo(self.safeAreaLayoutGuide.snp.center)
            make.leading.greaterThanOrEqualTo(snp.leading).offset(Spacing.medium).priority(999)
            make.trailing.lessThanOrEqualTo(snp.trailing).offset(-Spacing.medium).priority(999)

        }
    }

}
