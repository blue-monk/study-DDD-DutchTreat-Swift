//
//  EnumMap.swift
//  study_DDD_DutchTreat_Swift
//
//  Created by blue-monk on 2020/01/28.
//  Copyright © 2020 blue-monk. All rights reserved.
//

import Foundation

struct EnumMap<Enum: CaseIterable & Hashable, Value> {

    private let valuesByEnum: [Enum : Value]
}

//MARK: 初期化
extension EnumMap {

    init(resolver: (Enum) -> Value) {

        var values = [Enum : Value]()

        for key in Enum.allCases {
            values[key] = resolver(key)
        }

        self.valuesByEnum = values
    }
}



//MARK: subscript
extension EnumMap {

    subscript(key: Enum) -> Value {
        return valuesByEnum[key]!             //NOTE: CaseIterable.allCases を使って初期化しているので安全
    }
}
