//
//  PaymentLevelSpecifics+Fixture.swift
//  study_DDD_DutchTreat_SwiftTests
//
//  Created by blue-monk on 2020/01/26.
//  Copyright © 2020 blue-monk. All rights reserved.
//

import Foundation
@testable import study_DDD_DutchTreat_Swift

extension PaymentLevelSpecifics {

    enum Variation {

        case 全て同値
        case 全て異値(more: Int, std: Int, less: Int)
        case moreとstandardが同値
        case moreとlessが同値
        case standardとlessが同値

        func paymentLevelSpecifics() -> PaymentLevelSpecifics {

            switch self {
                case .全て同値                      : return try! PaymentLevelSpecifics(moreWeight: Weight(3), standardWeight: Weight(3), lessWeight: Weight(3))
                case let .全て異値(more, std, less) : return try! PaymentLevelSpecifics(moreWeight: Weight(more), standardWeight: Weight(std), lessWeight: Weight(less))
                case .moreとstandardが同値          : fatalError("今のところ使ってない")
                case .moreとlessが同値              : fatalError("今のところ使ってない")
                case .standardとlessが同値          : fatalError("今のところ使ってない")
            }
        }
    }
}
