//
//  Money.swift
//  study_DDD_DutchTreat_Swift
//
//  Created by blue-monk on 2020/01/26.
//  Copyright © 2020 blue-monk. All rights reserved.
//

import Foundation

struct Money: Equatable, Hashable {

    var amount: Decimal
    let currency: Currency
    let roundingMode: Decimal.RoundingMode
}

//MARK: 初期化
extension Money {

    init(_ amount: Decimal, _ currency: Currency, roundingMode: Decimal.RoundingMode = .plain) {

        self.amount = Rounder.round(amount, with: currency.minorUnit(), and: .plain)
        self.currency = currency
        self.roundingMode = roundingMode
    }
}

//MARK: 丸め処理
extension Money {

    private var rounded: Self {
        rounded(with: currency.minorUnit(), and: roundingMode)
    }

    func rounded(with scale: Scale, and mode: Decimal.RoundingMode) -> Self {

        let rounded = Rounder.round(amount, with: scale, and: mode)
        return Money(rounded, currency)
    }
}

//MARK: Comparable 準拠
extension Money: Comparable {

    static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.amount < rhs.amount
    }
}

//MARK: 一貫性チェック（通貨と丸めモードを型パラメータにしていないので必要）
extension Money {

    private static func _checkConsistency(_ lhs: Self, _ rhs: Self) {
        precondition(lhs.currency == rhs.currency && lhs.roundingMode == rhs.roundingMode, "通貨または丸めモードが整合していません")
    }
}

//MARK: Money同士の加減算
//NOTE: 通貨と丸めモードを型パラメータにしていないので AdditiveArithmeticに準拠できない。
extension Money {

    static func + (lhs: Self, rhs: Self) -> Money {

        _checkConsistency(lhs, rhs)
        return Money(lhs.amount + rhs.amount, lhs.currency)
    }

    static func += (lhs: inout Self, rhs: Self) {

        _checkConsistency(lhs, rhs)
        lhs.amount += rhs.amount
    }

    static func - (lhs: Self, rhs: Self) -> Self {

        _checkConsistency(lhs, rhs)
        return Money(lhs.amount - rhs.amount, lhs.currency)
    }

    static func -= (lhs: inout Self, rhs: Self) {

        _checkConsistency(lhs, rhs)
        lhs.amount -= rhs.amount
    }
}

//MARK: 他の型との乗算
//CAUTION: 計算後、currency の minorUnit と roundingMode で丸めている。割り勘ドメインではこれでいいかな？
extension Money {

    static func * (lhs: Self, rhs: Decimal) -> Self {
        Money(lhs.amount * rhs, lhs.currency)
    }

    static func * (lhs: Self, rhs: Int) -> Self {
        lhs * Decimal(rhs)
    }


    static func * (lhs: Decimal, rhs: Self) -> Self {
        rhs * lhs
    }

    static func * (lhs: Int, rhs: Self) -> Self {
        rhs * lhs
    }


    static func *= (lhs: inout Money, rhs: Decimal) {
        lhs.amount *= rhs
    }

    static func *= (lhs: inout Self, rhs: Int) {
        lhs.amount *= Decimal(rhs)
    }
}

//MARK: 他の型との除算
//CAUTION: 計算後、currency の minorUnit と roundingMode で丸めている。割り勘ドメインではこれでいいかな？
extension Money {

    static func / (lhs: Self, rhs: Decimal) -> Self {
        Money(lhs.amount / rhs, lhs.currency)
    }

    static func / (lhs: Self, rhs: Int) -> Self {
        lhs / Decimal(rhs)
    }
}


//MARK: 負値
extension Money {

    static prefix func - (money: Self) -> Self {
        Money(-money.amount, money.currency, roundingMode: money.roundingMode)
    }
}



extension Money: CustomStringConvertible {

    var description: String {
        debugString(subject: self, value1: amount, value2: currency, value3: roundingMode)
    }
}
