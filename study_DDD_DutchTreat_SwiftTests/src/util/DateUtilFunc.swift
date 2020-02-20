//
//  DateUtil.swift
//  study_DDD_DutchTreat_SwiftTests
//
//  Created by blue-monk on 2020/01/26.
//  Copyright © 2020 blue-monk. All rights reserved.
//

import Foundation
@testable import study_DDD_DutchTreat_Swift

func dateOf(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) throws -> Date {

    guard let date = Calendar.gregorianDateOf(year: year, month: month, day: day, hour: hour, minute: minute, second: second) else {
        //TODO: これは fatalErrorの方がいいのでは？
        throw DomainError.unknownDate(dateComponents: DateComponents(year: year, month: month, day: day, hour: hour, minute: minute, second: second))
    }

    return date
}
