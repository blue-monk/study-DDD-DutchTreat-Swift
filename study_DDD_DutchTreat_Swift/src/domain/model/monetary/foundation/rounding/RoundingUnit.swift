//
//  RoundingUnit.swift
//  study_DDD_DutchTreat_Swift
//
//  Created by blue-monk on 2020/01/26.
//  Copyright © 2020 blue-monk. All rights reserved.
//

import Foundation
import Surge

enum RoundingUnit: Double {

    /// 1 （JPYの場合は円／USDの場合はセント など）単位にする．
    case `default` = 1

    /// 10 （JPYの場合は円／USDの場合はセント など）単位にする．例えば 3654円 → 3650円 のように。
    case ten = 10

    /// 100 （JPYの場合は円／USDの場合はセント など）単位にする．例えば 3654円 → 3700円 のように。
    case hundred = 100
}

//MARK: 導出情報
extension RoundingUnit {

    func scale(for currency: Currency) -> Scale {

        let offsetScale = Int(log10(rawValue))
        return Scale(value: currency.minorUnit() - offsetScale)
    }
}



extension RoundingUnit: CustomDebugStringConvertible {

    var debugDescription: String {
        return debugString(subject: self, value: rawValue)
    }
}
