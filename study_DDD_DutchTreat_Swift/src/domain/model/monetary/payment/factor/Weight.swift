//
//  Weight.swift
//  study_DDD_DutchTreat_Swift
//
//  Created by blue-monk on 2020/01/26.
//  Copyright © 2020 blue-monk. All rights reserved.
//

import Foundation

struct Weight: Hashable {

    var value: Int

    //MARK: 初期化
    init(_ value: Int) throws {

        guard value > -1 else {
            throw DomainError.invalid(message: "比重は 0 以上を指定してください．value=\(value)]")
        }
        
        self.value = value
    }
}



//MARK: Comparable 準拠
extension Weight: Comparable {

    static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.value < rhs.value
    }
}

//MARK: Accumulatable 準拠
extension Weight: Accumulatable {

    static var zero: Self {
        return try! Weight(0)                           //NOTE: 0 > -1 なので try!
    }

    static func + (lhs: Self, rhs: Self) -> Self {
        try! Weight(lhs.value + rhs.value)              //NOTE: 必ず > -1 になるので try!
    }

//    static func += (lhs: inout Self, rhs: Self) {
//        lhs.value += rhs.value
//    }
}



extension Weight: CustomDebugStringConvertible {

    var debugDescription: String {
        "\(value)"
    }
}
