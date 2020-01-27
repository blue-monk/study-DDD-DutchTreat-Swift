//
//  Sequence+arithmetic.swift
//  study_DDD_DutchTreat_Swift
//
//  Created by blue-monk on 2020/01/12.
//

import Foundation

extension Sequence where Element: Accumulatable {

    func sum() -> Element {
        return reduce(.zero, +)
    }
}

extension Sequence where Element: AdditiveArithmetic {

    func sum() -> Element {
        return reduce(.zero, +)
    }
}
