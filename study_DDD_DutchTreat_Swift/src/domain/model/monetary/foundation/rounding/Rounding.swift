//
//  Rounding.swift
//  study_DDD_DutchTreat_Swift
//
//  Created by blue-monk on 2020/01/26.
//  Copyright © 2020 blue-monk. All rights reserved.
//

import Foundation

enum Rounding: String {

    case harfUp
    case up
    case down
    case bankers
}



//MARK: 導出属性
extension Rounding {

    var mode: Decimal.RoundingMode {

        switch self {
            case .harfUp:  return Decimal.RoundingMode.plain
            case .up:      return Decimal.RoundingMode.up
            case .down:    return Decimal.RoundingMode.down
            case .bankers: return Decimal.RoundingMode.bankers
        }
    }
}



extension Rounding: CustomDebugStringConvertible {

    var debugDescription: String {
        return debugString(subject: self, value: rawValue)
    }
}
