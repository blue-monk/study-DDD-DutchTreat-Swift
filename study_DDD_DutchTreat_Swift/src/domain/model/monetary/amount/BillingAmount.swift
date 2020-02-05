//
//  BillingAmount.swift
//  study_DDD_DutchTreat_Swift
//
//  Created by blue-monk on 2020/01/26.
//  Copyright © 2020 blue-monk. All rights reserved.
//

import Foundation

struct BillingAmount {

    private let money: Money

    var currency: Currency {
        return money.currency
    }
}

//MARK: 初期化
extension BillingAmount {

    init(_ amount: Decimal, currency: Currency) {
        money = Money(amount, currency)
    }
}

//MARK: Weight との演算
extension BillingAmount {

    static func * (lhs: Self, rhs: Weight) -> PaymentAmount {
        PaymentAmount(lhs.money * rhs.value)
    }
}

//MARK: TotalPaymentAmount との演算
extension BillingAmount {

    static func - (lhs: Self, rhs: TotalPaymentAmount) -> DifferenceAmount {
        DifferenceAmount(lhs.money - rhs.money)
    }

    static func == (lhs: Self, rhs: TotalPaymentAmount) -> Bool {
        lhs.money == rhs.money
    }
}



extension BillingAmount: CustomDebugStringConvertible {

    var debugDescription: String {
        debugString(subject: self, value1: money, value2: currency)
    }
}

