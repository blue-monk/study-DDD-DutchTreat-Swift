//
//  DifferenceAdjuster.swift
//  study_DDD_DutchTreat_Swift
//
//  Created by blue-monk on 2020/01/26.
//  Copyright © 2020 blue-monk. All rights reserved.
//

import Foundation

protocol DifferenceAdjuster {

    func adjust(_ difference: DifferenceAmount, in memberPayments: MemberPayments) -> MemberPayments
}
