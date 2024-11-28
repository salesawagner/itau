//
//  DetailsProtocols.swift
//  challenge
//
//  Created by Wagner Sales
//

import Foundation

protocol DetailsInputProtocol {
    var viewController: DetailsOutputProtocol? { get set }
    var sectionTitle: String { get }
    func didTapReload()
    func pullToRefresh()
    func viewDidLoad()
}

protocol DetailsOutputProtocol {
    func setTitle(_ title: String)
    func startLoading()
    func success(dataSource: [DetailsRowViewModel])
    func failure()
}
