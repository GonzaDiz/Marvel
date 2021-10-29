//
//  CharacterTableViewCell.swift
//  Marvel
//
//  Created by Gonzalo Diz on 29/10/2021.
//

import AlamofireImage
import UIKit

final class CharacterTableViewCell: UITableViewCell {

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()

    private lazy var characterImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        contentView.addSubview(nameLabel)
        contentView.addSubview(characterImageView)

        characterImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView).offset(Spacing.medium)
            make.bottom.equalTo(contentView).offset(-Spacing.medium).priority(999)
            make.width.height.equalTo(100)
        }

        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(characterImageView.snp.trailing).offset(Spacing.small)
            make.trailing.equalTo(contentView.snp.trailing).offset(-Spacing.medium)
            make.top.equalTo(contentView).offset(Spacing.large)
        }
    }
}
