//
//  ListRow.swift
//  challenge
//
//  Created by Wagner Sales
//

import UIKit
import API

final class ListCell: UITableViewCell {
    static var identifier = String(describing: ListCell.self)

    // MARK: Properties

    private let repositoryNameLabel = UILabel()
    private let repositoryDescriptionLabel = UILabel()
    private let repositoryForkLabel = UILabel()
    private let repositoryStarLabel = UILabel()

    private let ownerView = UIView()
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
        setupOwnerView()
        setupStackView()
        selectionStyle = .none
        contentView.backgroundColor = .clear
        backgroundColor = .clear
    }

    private func setupImageView() {
        let size = 50.0
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

        repositoryDescriptionLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
        repositoryDescriptionLabel.textColor = .darkText
        repositoryDescriptionLabel.numberOfLines = 2

        repositoryForkLabel.font = UIFont.preferredFont(forTextStyle: .body)
        repositoryForkLabel.textColor = .init(r: 224, g: 149, b: 14)
        repositoryForkLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        repositoryStarLabel.font = UIFont.preferredFont(forTextStyle: .body)
        repositoryStarLabel.textColor = .init(r: 224, g: 149, b: 14)

        // owner
        ownerNameLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
        ownerNameLabel.textColor = .init(r: 26, g: 147, b: 218)

        ownerFullNameLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
        ownerFullNameLabel.textColor = .darkText
    }

    private func setupOwnerView() {
        ownerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ownerView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }

    private func setupStackView() {
        let countsStackView = UIStackView()
        countsStackView.axis = .horizontal
        countsStackView.spacing = 16
        countsStackView.alignment = .top
        countsStackView.addArrangedSubview(repositoryForkLabel)
        countsStackView.addArrangedSubview(repositoryStarLabel)

        let repositoryStackView = UIStackView()
        repositoryStackView.axis = .vertical
        repositoryStackView.spacing = 8
        repositoryStackView.addArrangedSubview(repositoryNameLabel)
        repositoryStackView.addArrangedSubview(repositoryDescriptionLabel)
        repositoryStackView.addArrangedSubview(countsStackView)

        let ownerStackView = UIStackView()
        ownerStackView.axis = .vertical
        ownerStackView.alignment = .center
        ownerStackView.addArrangedSubview(ownerImageView)
        ownerStackView.addArrangedSubview(ownerNameLabel)
        ownerStackView.addArrangedSubview(ownerFullNameLabel)
        ownerStackView.fill(on: ownerView)

        let mainStackView = UIStackView()
        mainStackView.axis = .horizontal
        mainStackView.spacing = 16
        mainStackView.addArrangedSubview(repositoryStackView)
        mainStackView.addArrangedSubview(ownerView)
        mainStackView.fill(on: contentView, insets: .all(constant: 24))
    }

    // MARK: Internal Methods

    func setup(with viewModel: ListRowViewModel) {
        repositoryNameLabel.text = viewModel.repository.name
        repositoryDescriptionLabel.text = viewModel.repository.description
        repositoryForkLabel.text = viewModel.repository.forks.friendly
        repositoryStarLabel.text = viewModel.repository.stars.friendly

        ownerImageView.loadFromUrl(viewModel.owner.avatarURL)
        ownerNameLabel.text = viewModel.owner.name
        ownerFullNameLabel.text = viewModel.owner.fullName
    }
}

#Preview {
    ListViewController.create(with: ListViewModel(api: WASAPI(environment: Environment.local)))
}
