//
//  BillingAmount.swift
//  study_DDD_DutchTreat_Swift
//
//  Created by blue-monk on 2020/01/26.
//  Copyright © 2020 blue-monk. All rights reserved.
//

import Foundation

struct BillingAmount {

    private let amountOfMoney: AmountOfMoney

    var currency: Currency {
        return amountOfMoney.currency
    }
}

//MARK: 初期化
extension BillingAmount {

    init(_ amount: Decimal, currency: Currency) {
        amountOfMoney = AmountOfMoney(amount, currency: currency)
    }
}

//MARK: Weight との演算
extension BillingAmount {

    static func * (lhs: BillingAmount, rhs: Weight) -> PaymentAmount {
        PaymentAmount(lhs.amountOfMoney * rhs.value)
    }
}

//MARK: TotalPaymentAmount との演算
extension BillingAmount {

    static func - (lhs: BillingAmount, rhs: TotalPaymentAmount) -> DifferenceAmount {
        DifferenceAmount(lhs.amountOfMoney - rhs.amountOfMoney)
    }

    static func == (lhs: BillingAmount, rhs: TotalPaymentAmount) -> Bool {
        lhs.amountOfMoney == rhs.amountOfMoney
    }
}



extension BillingAmount: CustomDebugStringConvertible {

    var debugDescription: String {
        debugString(subject: self, value1: amountOfMoney, value2: currency)
    }
}

