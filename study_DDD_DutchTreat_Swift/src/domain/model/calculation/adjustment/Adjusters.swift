//
//  Adjusters.swift
//  study_DDD_DutchTreat_Swift
//
//  Created by blue-monk on 2020/01/26.
//  Copyright © 2020 blue-monk. All rights reserved.
//

import Foundation

struct OrganizerSacrificedAdjuster: DifferenceAdjuster {

    func adjust(_ difference: DifferenceAmount, in memberPayments: MemberPayments) -> MemberPayments {

        let adjusted = memberPayments
                .map() { $0.addingPaymentAmountIfMemberIsPartyOrganizer(additionalAmount: difference) }

        return MemberPayments(rawMemberPayments: adjusted)
    }
}

struct SecretarySacrificedAdjuster: DifferenceAdjuster {

    func adjust(_ difference: DifferenceAmount, in memberPayments: MemberPayments) -> MemberPayments {

        let adjusted = _adjustOne(of: memberPayments, adjustmentAmount: difference, where: \.isSecretary)

        guard let adjustedMemberPayment = adjusted else {
            fatalError("TODO: パーティメンバーに幹事がいなかったら、「調整先に幹事」を選択できないようにする。")
        }

        return memberPayments.replacing(memberPayment: adjustedMemberPayment)
    }
}

struct GenaralMemberSacrificedAdjuster: DifferenceAdjuster {

    func adjust(_ difference: DifferenceAmount, in memberPayments: MemberPayments) -> MemberPayments {

        let adjusted = _adjustOne(of: memberPayments, adjustmentAmount: difference, where: \.isGeneralMember)

        guard let adjustedMemberPayment = adjusted else {
            fatalError("TODO: パーティメンバーに一般がいなかったら、「調整先に一般」を選択できないようにする。")
        }

        return memberPayments.replacing(memberPayment: adjustedMemberPayment)
    }
}

struct RandomSacrificedAdjuster: DifferenceAdjuster {

    func adjust(_ difference: DifferenceAmount, in memberPayments: MemberPayments) -> MemberPayments {
        memberPayments.changingPaymentAmountRandomly(additionalAmount: difference)
    }
}



fileprivate func _adjustOne(of memberPayments: MemberPayments, adjustmentAmount: DifferenceAmount, where predicate: KeyPath<Member, Bool>) -> MemberPayment? {

    return memberPayments
            .filter() { $0.member[keyPath: predicate] }
            .shuffled()
            .first
            .map() { $0.addingPaymentAmount(adjustmentAmount) }
}
