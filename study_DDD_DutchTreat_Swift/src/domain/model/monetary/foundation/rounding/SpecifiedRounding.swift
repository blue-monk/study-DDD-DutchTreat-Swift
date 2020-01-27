//
//  SpecifiedRounding.swift
//  study_DDD_DutchTreat_Swift
//
//  Created by blue-monk on 2020/01/26.
//  Copyright © 2020 blue-monk. All rights reserved.
//

import Foundation

struct SpecifiedRounding {

    let roundingUnit: RoundingUnit
    let rounding: Rounding
}

//MARK: 導出情報
extension SpecifiedRounding {

    var roundingMode: Decimal.RoundingMode {
        rounding.mode
    }

    func scale(for currency: Currency) -> Scale {
        roundingUnit.scale(for: currency)
    }
}
