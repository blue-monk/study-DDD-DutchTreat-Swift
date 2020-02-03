//
//  SummableMoney.swift
//  study_DDD_DutchTreat_Swift
//
//  Created by blue-monk on 2020/01/19.
//  Copyright © 2020 blue-monk. All rights reserved.
//

import Foundation

protocol AccumulatableMoney {

    static func zero(currency: Currency) -> Self

    static func + (lhs: Self, rhs: Self) -> Self

//    static func += (lhs: inout Self, rhs: Self)
}


//MARK: Sequence 拡張
extension Sequence where Element: AccumulatableMoney {

    func sum(in currency: Currency) -> Element {
        reduce(.zero(currency: currency), +)
    }
}
