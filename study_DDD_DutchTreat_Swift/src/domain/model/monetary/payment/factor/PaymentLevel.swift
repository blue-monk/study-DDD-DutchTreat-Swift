//
//  PaymentLevel.swift
//  study_DDD_DutchTreat_Swift
//
//  Created by blue-monk on 2020/01/26.
//  Copyright © 2020 blue-monk. All rights reserved.
//

import Foundation

enum PaymentLevel: String {

    /* 多め */
    case more

    /* 普通 */
    case standard

    /* 少なめ */
    case less
}



extension PaymentLevel: CustomDebugStringConvertible {

    var debugDescription: String {
        debugString(subject: self, value: rawValue)
    }
}
