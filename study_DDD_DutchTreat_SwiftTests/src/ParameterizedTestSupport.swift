//
//  ParameterizedTestSupport.swift
//  study_DDD_DutchTreat_SwiftTests
//
//  Created by blue-monk on 2020/01/26.
//  Copyright © 2020 blue-monk. All rights reserved.
//

import Foundation

protocol TestCaseProvider {

    associatedtype DataSeed
    associatedtype Expectation

    static func cases() -> [(DataSeed, expect: Expectation)]
}

protocol TestDataSeed {

    associatedtype T

    func makeInputData() -> T
}
