//
//  IntExtensions.swift
//  challenge
//
//  Created by Wagner Sales
//
// https://stackoverflow.com/questions/48371093/formatting-numbers-into-friendly-ks

import Foundation

extension Int {
    var friendly: String {
        let number = Double(self)
        let billion = number / 1_000_000_000
        let million = number / 1_000_000
        let thousand = number / 1000

        if billion >= 1.0 {
            return "\(round(billion * 10) / 10)B"
        } else if million >= 1.0 {
            return "\(round(million * 10) / 10)M"
        } else if thousand >= 1.0 {
            return "\(round(thousand * 10) / 10)K"
        } else {
            return "\(Int(number))"
        }
    }
}
