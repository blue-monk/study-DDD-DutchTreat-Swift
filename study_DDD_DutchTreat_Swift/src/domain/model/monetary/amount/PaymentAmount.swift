//
//  PaymentAmount.swift
//  study_DDD_DutchTreat_Swift
//
//  Created by blue-monk on 2020/01/26.
//  Copyright © 2020 blue-monk. All rights reserved.
//

import Foundation

struct PaymentAmount: Equatable {

    let money: Money
    
    var currency: Currency {
        money.currency
    }

    //MARK: 初期化
    init(_ money: Money) {
        self.money = money
    }
}

//MARK: 初期化
extension PaymentAmount {

    init(_ amount: Decimal, currency: Currency) {
        money = Money(amount, currency)
    }

    init(_ differenceAmount: DifferenceAmount) {
        money = differenceAmount.money
    }
}



//MARK: 丸め処理
extension PaymentAmount {

    func rounded(by specifiedRounding: SpecifiedRounding) -> Self {

        let currency = money.currency
        let scale = specifiedRounding.scale(for: currency)
        let roundingMode = specifiedRounding.roundingMode
        let roundedMoney = money.rounded(with: scale, and: roundingMode)

        return PaymentAmount(roundedMoney)
    }
}


//MARK: AccumulatableMoney 準拠
extension PaymentAmount: AccumulatableMoney {

    static func zero(currency: Currency) -> Self {
        return PaymentAmount(Decimal(0), currency: currency)
    }

    static func + (lhs: Self, rhs: Self) -> Self {
        PaymentAmount(lhs.money + rhs.money)
    }

//    static func += (lhs: inout Self, rhs: Self) {
//        lhs.money += rhs.money
//    }
}

//MARK: DifferenceAmount 加算
extension PaymentAmount {
    
    static func + (lhs: Self, rhs: DifferenceAmount) -> Self {
        PaymentAmount(lhs.money + rhs.money)
    }

//    static func += (lhs: inout Self, rhs: DifferenceAmount) {
//        lhs.money += rhs.money
//    }

}

//MARK: Weight との演算
extension PaymentAmount {
    
    static func / (lhs: Self, rhs: Weight) -> Self {
        PaymentAmount(lhs.money / rhs.value)
    }
}



extension PaymentAmount: CustomDebugStringConvertible {

    var debugDescription: String {
        debugString(subject: self, value1: money, value2: currency)
    }
}
