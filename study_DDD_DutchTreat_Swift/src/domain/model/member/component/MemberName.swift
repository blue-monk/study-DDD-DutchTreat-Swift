//
//  MemberName.swift
//  study_DDD_DutchTreat_Swift
//
//  Created by blue-monk on 2020/01/26.
//  Copyright © 2020 blue-monk. All rights reserved.
//

import Foundation

struct MemberName: Equatable {

    let value: String
}



extension MemberName: CustomDebugStringConvertible {

    var debugDescription: String {
        debugString(subject: self, value: value)
    }
}
