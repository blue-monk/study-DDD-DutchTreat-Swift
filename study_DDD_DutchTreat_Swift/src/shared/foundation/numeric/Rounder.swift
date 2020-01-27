//
//  Rounder.swift
//  study_DDD_DutchTreat_Swift
//
//  Created by blue-monk on 2020/01/26.
//  Copyright © 2020 blue-monk. All rights reserved.
//

import Foundation

struct Rounder {

    static func round(_ amount: Decimal, with scale: Scale, and mode: Decimal.RoundingMode) -> Decimal {

        var rounded = Decimal()
        var approximate = amount
        NSDecimalRound(&rounded, &approximate, scale.value, mode)
        
        return rounded
    }
}
