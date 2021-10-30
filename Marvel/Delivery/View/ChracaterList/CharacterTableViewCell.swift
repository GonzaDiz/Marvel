//
//  CharacterTableViewCell.swift
//  Marvel
//
//  Created by Gonzalo Diz on 29/10/2021.
//

import AlamofireImage
import UIKit

final class CharacterTableViewCell: UITableViewCell {

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground

        view.layer.cornerRadius = 8

        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.25
        view.layer.shadowRadius = 8
        return view
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title2, compatibleWith: .none)
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 0
        label.accessibilityIdentifier = A11y.CharacterTableViewCell.nameLabel
        return label
    }()

    private lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()

        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        characterImageView.af.cancelImageRequest()
        characterImageView.image = nil
     }

    func setup(name: String?, imageURL: URL?) {
        nameLabel.text = name?.uppercased()
        if let imageURL = imageURL {
            characterImageView.af.setImage(withURL: imageURL)
        }
    }

    private func setupConstraints() {
        contentView.addSubview(containerView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(characterImageView)

        containerView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(Spacing.small)
            make.bottom.equalTo(contentView).offset(-Spacing.small)
            make.leading.equalTo(contentView).offset(Spacing.medium)
            make.trailing.equalTo(contentView).offset(-Spacing.medium)
        }

        characterImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(containerView).offset(Spacing.medium)
            make.bottom.equalTo(containerView).offset(-Spacing.medium).priority(999)
            make.width.height.equalTo(100)
        }

        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(characterImageView.snp.trailing).offset(Spacing.medium)
            make.trailing.equalTo(containerView.snp.trailing).offset(-Spacing.medium)
            make.top.equalTo(containerView).offset(Spacing.large)
        }
    }
}
