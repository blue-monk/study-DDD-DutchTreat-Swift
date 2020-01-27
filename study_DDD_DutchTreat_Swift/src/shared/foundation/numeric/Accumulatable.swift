//
//  Accumulatable.swift
//  study_DDD_DutchTreat_Swift
//
//  Created by blue-monk on 2020/01/26.
//  Copyright © 2020 blue-monk. All rights reserved.
//

import Foundation

protocol Accumulatable {

    static var zero: Self { get }

    static func + (lhs: Self, rhs: Self) -> Self

//    static func += (lhs: inout Self, rhs: Self)
}
