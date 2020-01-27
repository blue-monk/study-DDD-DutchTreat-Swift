//
//  Debug.swift
//  study_DDD_DutchTreat_Swift
//
//  Created by blue-monk on 2020/01/20.
//  Copyright © 2020 blue-monk. All rights reserved.
//

import Foundation


func debugString<S, V>(subject: S, rawValue: V) -> String {
    return "\(String(describing: type(of: subject)))(.\(rawValue))"
}

func debugString<S, V>(subject: S, value: V) -> String {
    return "\(String(describing: type(of: subject)))(\(value))"
}

func debugString<S, V1, V2>(subject: S, value1: V1, value2: V2) -> String {
    return "\(String(describing: type(of: subject)))(\(value1), \(value2))"
}

func debugString<S, V1, V2, V3>(subject: S, value1: V1, value2: V2, value3: V3) -> String {
    return "\(String(describing: type(of: subject)))(\(value1), \(value2), \(value3))"
}

func debugString<S, V1, V2, V3, V4>(subject: S, value1: V1, value2: V2, value3: V3, value4: V4) -> String {
    return "\(String(describing: type(of: subject)))(\(value1), \(value2), \(value3), \(value4))"
}

func debugString<S, V1, V2, V3, V4, V5>(subject: S, value1: V1, value2: V2, value3: V3, value4: V4, value5: V5) -> String {
    return "\(String(describing: type(of: subject)))(\(value1), \(value2), \(value3), \(value4), \(value5))"
}

func debugString<S, V1, V2, V3, V4, V5, V6>(subject: S, value1: V1, value2: V2, value3: V3, value4: V4, value5: V5, value6: V6) -> String {
    return "\(String(describing: type(of: subject)))(\(value1), \(value2), \(value3), \(value4), \(value5), \(value6))"
}

func debugString<S, V1, V2, V3, V4, V5, V6, V7>(subject: S, value1: V1, value2: V2, value3: V3, value4: V4, value5: V5, value6: V6, value7: V7) -> String {
    return "\(String(describing: type(of: subject)))(\(value1), \(value2), \(value3), \(value4), \(value5), \(value6), \(value7))"
}
