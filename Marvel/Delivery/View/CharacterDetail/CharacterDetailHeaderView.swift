//
//  CharacterDetailHeaderView.swift
//  Marvel
//
//  Created by Gonzalo Diz on 29/10/2021.
//

import AlamofireImage
import SnapKit
import UIKit

final class CharacterDetailHeaderView: UIView {
    private lazy var imageView = UIImageView()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body, compatibleWith: .current)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0

        return label
    }()

    init(imageURL: URL?, description: String?) {
        super.init(frame: .zero)
        setupConstraints()

        descriptionLabel.text = description

        if let imageURL = imageURL {
            imageView.af.setImage(withURL: imageURL)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        addSubview(imageView)
        addSubview(descriptionLabel)

        imageView.snp.makeConstraints { make in
            make.trailing.leading.top.equalTo(self)
            make.height.equalTo(300)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(Spacing.medium)
            make.leading.equalTo(snp.leading).offset(Spacing.small)
            make.trailing.equalTo(snp.trailing).offset(-Spacing.small).priority(999)
            make.bottom.equalTo(snp.bottom).offset(-Spacing.small).priority(999)
        }
    }
}
