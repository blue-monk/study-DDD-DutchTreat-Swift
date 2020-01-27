//
//  PartyName+Fixture.swift
//  study_DDD_DutchTreat_SwiftTests
//
//  Created by blue-monk on 2020/01/26.
//  Copyright © 2020 blue-monk. All rights reserved.
//

import Foundation
@testable import study_DDD_DutchTreat_Swift

extension PartyName {

    static func fixture(value: String = "星を見上げる会") -> PartyName {
        PartyName(value: value)
    }
}
