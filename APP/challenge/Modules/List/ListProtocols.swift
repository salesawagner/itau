//
//  ListProtocols.swift
//  challenge
//
//  Created by Wagner Sales
//

import Foundation

protocol ListInputProtocol {
    var viewController: ListOutputProtocol? { get set }
    func didSelectRow(indexPath: IndexPath)
    func didTapReload()
    func pullToRefresh()
    func viewDidLoad()
    func prefetchRows()
}

protocol ListOutputProtocol {
    func startLoading()
    func requestSuccess(dataSource: [ListRowViewModel])
    func updateSuccess(dataSource: [ListRowViewModel])
    func failure()
}
