//
//  DetailsRowViewModel.swift
//  challenge
//
//  Created by Wagner Sales
//

import Foundation

struct DetailsRowViewModel {
    let pullRequest: PullRequestViewModel
    let owner: OwnerViewModel
}

struct PullRequestViewModel {
    let id: Int
    let name: String
    let description: String
}
