//
//  PaymentAmount.swift
//  study_DDD_DutchTreat_Swift
//
//  Created by blue-monk on 2020/01/26.
//  Copyright © 2020 blue-monk. All rights reserved.
//

import Foundation

struct PaymentAmount: Equatable {

    var amountOfMoney: AmountOfMoney
    
    var currency: Currency {
        amountOfMoney.currency
    }
}

//MARK: 初期化
extension PaymentAmount {

    init(_ amount: Decimal, currency: Currency) {
        amountOfMoney = AmountOfMoney(amount, currency: currency)
    }

    init(_ differenceAmount: DifferenceAmount) {
        amountOfMoney = differenceAmount.amountOfMoney
    }

    init(_ amountOfMoney: AmountOfMoney) {
        self.amountOfMoney = amountOfMoney
    }
}

//MARK: 丸め処理
extension PaymentAmount {

    func rounded(by specifiedRounding: SpecifiedRounding) -> Self {

        let currency = amountOfMoney.currency
        let scale = specifiedRounding.scale(for: currency)
        let roundingMode = specifiedRounding.roundingMode
        let rounded = amountOfMoney.rounded(with: scale, and: roundingMode)

        return PaymentAmount(amountOfMoney: rounded)
    }
}


//MARK: AccumulatableMoney 準拠
extension PaymentAmount: AccumulatableMoney {

    static func zero(currency: Currency) -> Self {
        return PaymentAmount(Decimal(0), currency: currency)
    }

    static func + (lhs: Self, rhs: Self) -> Self {
        PaymentAmount(amountOfMoney: lhs.amountOfMoney + rhs.amountOfMoney)
    }

//    static func += (lhs: inout Self, rhs: Self) {
//        lhs.amountOfMoney += rhs.amountOfMoney
//    }
}

//MARK: DifferenceAmount 加算
extension PaymentAmount {
    
    static func + (lhs: Self, rhs: DifferenceAmount) -> Self {
        PaymentAmount(amountOfMoney: lhs.amountOfMoney + rhs.amountOfMoney)
    }

    static func += (lhs: inout Self, rhs: DifferenceAmount) {
        lhs.amountOfMoney += rhs.amountOfMoney
    }

}

//MARK: Weight との演算
extension PaymentAmount {
    
    static func / (lhs: Self, rhs: Weight) -> Self {
        PaymentAmount(lhs.amountOfMoney / rhs.value)
    }
}



extension PaymentAmount: CustomDebugStringConvertible {

    var debugDescription: String {
        debugString(subject: self, value1: amountOfMoney, value2: currency)
    }
}
