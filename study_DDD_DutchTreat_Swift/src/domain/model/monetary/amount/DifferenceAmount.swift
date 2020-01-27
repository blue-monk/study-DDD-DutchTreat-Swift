//
//  DifferenceAmount.swift
//  study_DDD_DutchTreat_Swift
//
//  Created by blue-monk on 2020/01/26.
//  Copyright © 2020 blue-monk. All rights reserved.
//

import Foundation

struct DifferenceAmount {

    let amountOfMoney: AmountOfMoney
}

//MARK: 初期化
extension DifferenceAmount {

    init(_ amountOfMoney: AmountOfMoney) {
        self.amountOfMoney = amountOfMoney
    }
}

//MARK: 判定
extension DifferenceAmount {

    func isZero() -> Bool {
        amountOfMoney == AmountOfMoney(Decimal.zero, currency: amountOfMoney.currency)
    }
}
