//
//  AmountOfMoney.swift
//  study_DDD_DutchTreat_Swift
//
//  Created by blue-monk on 2020/01/26.
//  Copyright © 2020 blue-monk. All rights reserved.
//

import Foundation

//TODO: 最初は Moneyは外部ライブラリを使おうとしていたのでこれを設けていたけど、Money自作にしたので要らないかな？
struct AmountOfMoney: Equatable {

    private var money: Money
}

//MARK: 初期化
extension AmountOfMoney {

    init(_ amount: Decimal, currency: Currency) {
        money = Money(amount, currency)
    }
}

//MARK: 導出属性
extension AmountOfMoney {

    var currency: Currency {
        money.currency
    }
}

//MARK: Comparable 準拠
extension AmountOfMoney: Comparable {

    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.money < rhs.money
    }
}

//MARK: 演算 加減算
extension AmountOfMoney {

    static func + (lhs: Self, rhs: Self) -> Self {
        AmountOfMoney(money: lhs.money + rhs.money)
    }

    static func - (lhs: Self, rhs: Self) -> Self {
        AmountOfMoney(money: lhs.money - rhs.money)
    }

    static func += (lhs: inout Self, rhs: Self) {
        lhs.money.amount += rhs.money.amount
    }

    static func -= (lhs: inout Self, rhs: Self) {
        lhs.money.amount -= rhs.money.amount
    }
}

//MARK: Int との演算
extension AmountOfMoney {

    static func * (lhs: Self, rhs: Int) -> Self {
        AmountOfMoney(money: (lhs.money * rhs))
    }

    static func / (lhs: Self, rhs: Int) -> Self {
        AmountOfMoney(money: lhs.money / rhs)
    }
}

//MARK: 丸め処理
extension AmountOfMoney {

    func rounded(with scale: Scale, and mode: Decimal.RoundingMode) -> Self {

        let rounded = money.rounded(with: scale, and: mode)
        return AmountOfMoney(money: rounded)
    }
}
