//
//  TracingSupport.swift
//  study_DDD_DutchTreat_SwiftTests
//
//  Created by blue-monk on 2020/01/27.
//  Copyright © 2020 blue-monk. All rights reserved.
//

import Foundation

func trace(file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
    print("\n===== \(function) =====")
}
