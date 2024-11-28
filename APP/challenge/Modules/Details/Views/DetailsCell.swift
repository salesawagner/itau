//
//  ListRow.swift
//  challenge
//
//  Created by Wagner Sales
//

import UIKit
import API

final class DetailsCell: UITableViewCell {
    static var identifier = String(describing: DetailsCell.self)

    // MARK: Properties

    private let repositoryNameLabel = UILabel()
    private let repositoryDescriptionLabel = UILabel()

    private let ownerImageView = UIImageView()
    private let ownerNameLabel = UILabel()
    private let ownerFullNameLabel = UILabel()

    // MARK: Inits

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle

    override func prepareForReuse() {
        super.prepareForReuse()
        ownerImageView.image = nil
        ownerImageView.backgroundColor = .clear
    }

    // MARK: Private Methods

    private func setupUI() {
        setupImageView()
        setupLabels()
        setupStackView()
        selectionStyle = .none
        contentView.backgroundColor = .clear
        backgroundColor = .clear
    }

    private func setupImageView() {
        let size = 30.0
        ownerImageView.backgroundColor = .gray
        ownerImageView.contentMode = .scaleAspectFill
        ownerImageView.translatesAutoresizingMaskIntoConstraints = false
        ownerImageView.layer.cornerRadius = size/2
        ownerImageView.clipsToBounds = true

        NSLayoutConstraint.activate([
            ownerImageView.widthAnchor.constraint(equalToConstant: size),
            ownerImageView.heightAnchor.constraint(equalToConstant: size)
        ])
    }

    private func setupLabels() {
        // repository
        repositoryNameLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        repositoryNameLabel.textColor = .init(r: 26, g: 147, b: 218)

        repositoryDescriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        repositoryDescriptionLabel.textColor = .darkText
        repositoryDescriptionLabel.numberOfLines = 2

        // owner
        ownerNameLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        ownerNameLabel.textColor = .init(r: 26, g: 147, b: 218)

        ownerFullNameLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        ownerFullNameLabel.textColor = .darkText
    }

    private func setupStackView() {
        let repositoryStackView = UIStackView()
        repositoryStackView.axis = .vertical
        repositoryStackView.spacing = 8
        repositoryStackView.addArrangedSubview(repositoryNameLabel)
        repositoryStackView.addArrangedSubview(repositoryDescriptionLabel)

        let ownerStackView = UIStackView()
        ownerStackView.axis = .horizontal
        ownerStackView.alignment = .center
        ownerStackView.spacing = 8
        ownerStackView.addArrangedSubview(ownerImageView)
        ownerStackView.addArrangedSubview(ownerNameLabel)
        ownerStackView.addArrangedSubview(ownerFullNameLabel)

        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.alignment = .leading
        mainStackView.spacing = 16
        mainStackView.addArrangedSubview(repositoryStackView)
        mainStackView.addArrangedSubview(ownerStackView)
        mainStackView.fill(on: contentView, insets: .all(constant: 24))
    }

    // MARK: Internal Methods

    func setup(with viewModel: DetailsRowViewModel) {
        repositoryNameLabel.text = viewModel.pullRequest.name
        repositoryDescriptionLabel.text = viewModel.pullRequest.description

        ownerImageView.loadFromUrl(viewModel.owner.avatarURL)
        ownerNameLabel.text = viewModel.owner.name
        ownerFullNameLabel.text = viewModel.owner.fullName
    }
}

#Preview {
    DetailsViewController.create(with: DetailsViewModel(
        api: WASAPI(environment: Environment.local),
        login: "",
        repository: ""
    ))
}
