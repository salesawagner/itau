//
//  WASErrorView.swift
//  challenge
//
//  Created by Wagner Sales
//

import UIKit

protocol WASErrorViewDelegate: AnyObject {
    func didTapReloadButton()
}

final class WASErrorView: UIView {
    // MARK: Private Properties

    private weak var delegate: WASErrorViewDelegate?
    private let titleLabel = UILabel()
    private let imageView = UIImageView()
    private let actionButton = UIButton()

    // MARK: Inits

    init(delegate: WASErrorViewDelegate?) {
        super.init(frame: .zero)
        self.delegate = delegate
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }

    // MARK: Private Methods

    private func setupUI() {
        setupTitleLabel()
        setupImageView()
        setupActionButton()
        setupStackView()
    }

    private func setupTitleLabel() {
        titleLabel.text = "Ocorreu um erro, tente novamente!"
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
    }

    private func setupImageView() {
        imageView.image = .init(named: "error-found")
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    private func setupActionButton() {
        actionButton.setTitle("Reload", for: .normal)
        actionButton.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
        actionButton.backgroundColor = .black

        NSLayoutConstraint.activate([
            actionButton.widthAnchor.constraint(equalToConstant: 100),
            actionButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setupStackView() {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 20
        addSubview(stackView)

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(actionButton)

        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }

    @objc
    private func didTapActionButton() {
        delegate?.didTapReloadButton()
    }
}
