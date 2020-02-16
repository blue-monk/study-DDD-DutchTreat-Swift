//
//  DifferenceAdjustmentPolicy.swift
//  study_DDD_DutchTreat_Swift
//
//  Created by blue-monk on 2020/01/26.
//  Copyright © 2020 blue-monk. All rights reserved.
//

import Foundation

enum DifferenceAdjustmentPolicy: String {

    case assignToOrganizer
    case assignToOneOfSecretary
    case assignToOneOfGenaral
    case assignRandomly
}



//MARK: 使用する DifferenceAdjuster
extension DifferenceAdjustmentPolicy {

    private func adjuster() -> DifferenceAdjuster {

        switch self {
            case .assignToOrganizer:      return OrganizerSacrificedAdjuster()
            case .assignRandomly:         return RandomSacrificedAdjuster()
            case .assignToOneOfSecretary: return SecretarySacrificedAdjuster()
            case .assignToOneOfGenaral:   return GenaralMemberSacrificedAdjuster()
        }
    }
}

//MARK: 差額調整（DifferenceAdjuster に委譲）
extension DifferenceAdjustmentPolicy {

    func adjust(_ difference: DifferenceAmount, in memberPayments: MemberPayments) -> MemberPayments {
        adjuster().adjust(difference, in: memberPayments)
    }
}



extension DifferenceAdjustmentPolicy: CustomDebugStringConvertible {

    var debugDescription: String {
        return debugString(subject: self, value: rawValue)
    }
}
