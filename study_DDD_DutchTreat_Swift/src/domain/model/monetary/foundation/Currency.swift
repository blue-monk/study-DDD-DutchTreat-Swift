//
//  Currency.swift
//  study_DDD_DutchTreat_Swift
//
//  Created by blue-monk on 2020/01/26.
//  Copyright © 2020 blue-monk. All rights reserved.
//

import Foundation

enum Currency {
    
    case JPY
    case USD

    private struct Const {
        let code: String
        let sign: String
        let name: String
        let minorUnit: Int
    }

    private static let _constants = [
        JPY : Const(code: "JPY", sign: "¥", name: "Yen", minorUnit: 0),
        USD : Const(code: "USD", sign: "$", name: "US Dollar", minorUnit: 2),
    ]
}

//MARK: 属性
extension Currency {

    func code() -> String {
        Currency._constants[self]!.code
    }

    func name() -> String {
        Currency._constants[self]!.name
    }

    func minorUnit() -> Scale {
        Scale(value: minorUnit())
    }

    func minorUnit() -> Int {
        Currency._constants[self]!.minorUnit
    }
}
