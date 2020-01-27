//
//  HoldDateTime+Fixture.swift
//  study_DDD_DutchTreat_SwiftTests
//
//  Created by blue-monk on 2020/01/26.
//  Copyright © 2020 blue-monk. All rights reserved.
//

import Foundation
@testable import study_DDD_DutchTreat_Swift

extension HoldDateTime {

    static func fixture(value: Date = try! dateOf(year: 2020, month: 1, day: 28, hour: 18, minute: 0, second: 0)) -> HoldDateTime {
        HoldDateTime(value: value)
    }
}
