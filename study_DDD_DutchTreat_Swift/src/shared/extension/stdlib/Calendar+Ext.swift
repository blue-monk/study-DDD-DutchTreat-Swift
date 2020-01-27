//
//  Calendar.swift
//  study_DDD_DutchTreat_Swift
//
//  Created by blue-monk on 2020/01/26.
//  Copyright © 2020 blue-monk. All rights reserved.
//

import Foundation

extension Calendar {

    static func gregorian() -> Calendar {
        Calendar(identifier: .gregorian)
    }

    static func gregorianDate(form dateComponents: DateComponents) -> Date? {

        let cal = Calendar.gregorian()
        return cal.date(from: dateComponents)
    }

    static func gregorianDateOf(year: Int, month: Int, day: Int) -> Date? {
        Calendar.gregorianDate(form: DateComponents(year: year, month: month, day: day))
    }

    static func gregorianDateOf(hour: Int, minute: Int, second: Int) -> Date? {
        Calendar.gregorianDate(form: DateComponents(hour: hour, minute: minute, second: second))
    }

    static func gregorianDateOf(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) -> Date? {
        Calendar.gregorianDate(form: DateComponents(year: year, month: month, day: day, hour: hour, minute: minute, second: second))
    }
}
