//
//  Member+Fixture.swift
//  study_DDD_DutchTreat_SwiftTests
//
//  Created by blue-monk on 2020/01/26.
//  Copyright © 2020 blue-monk. All rights reserved.
//

import Foundation
@testable import study_DDD_DutchTreat_Swift

extension Member {

    static func fixtureOfSecretary(memberName: String = "幹事", paymentLevel: PaymentLevel = .standard) -> Member {
        Member(name: MemberName(value: memberName), memberType: .secretary, paymentLevel: paymentLevel)
    }

    static func fixtureOfGeneral(memberName: String = "一般参加者", paymentLevel: PaymentLevel = .standard) -> Member {
        Member(name: MemberName(value: memberName), memberType: .generalMember, paymentLevel: paymentLevel)
    }
}
