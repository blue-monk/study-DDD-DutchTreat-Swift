//
//  Organizer+Fixture.swift
//  study_DDD_DutchTreat_SwiftTests
//
//  Created by blue-monk on 2020/01/26.
//  Copyright © 2020 blue-monk. All rights reserved.
//

import Foundation
@testable import study_DDD_DutchTreat_Swift

extension Organizer {

    static func fixture(name: String = "主催者X", paymentLevel: PaymentLevel = .standard) -> Organizer {
        Organizer(name: MemberName(value: name), paymentLevel: paymentLevel)
    }
}
