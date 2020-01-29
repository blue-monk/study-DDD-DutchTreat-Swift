//
//  Adjusters.swift
//  study_DDD_DutchTreat_Swift
//
//  Created by blue-monk on 2020/01/26.
//  Copyright © 2020 blue-monk. All rights reserved.
//

import Foundation

/// ［アジャスター］主催者に対して調整
struct OrganizerSacrificedAdjuster: DifferenceAdjuster {

    func adjust(_ difference: DifferenceAmount, in memberPayments: MemberPayments) -> MemberPayments {
        _adjust(difference, to: .partyOrganizer, in: memberPayments, messageWhenNotExists: "パーティメンバーに主催者がいないみたい...")
    }
}

/// ［アジャスター］幹事の1人に対して調整
struct SecretarySacrificedAdjuster: DifferenceAdjuster {

    func adjust(_ difference: DifferenceAmount, in memberPayments: MemberPayments) -> MemberPayments {
        _adjust(difference, to: .secretary, in: memberPayments, messageWhenNotExists: "TODO: パーティメンバーに幹事がいなかったら、「調整先に幹事」を選択できないようにする。")
    }
}

/// ［アジャスター］一般メンバーの1人に対して調整
struct GenaralMemberSacrificedAdjuster: DifferenceAdjuster {

    func adjust(_ difference: DifferenceAmount, in memberPayments: MemberPayments) -> MemberPayments {
        _adjust(difference, to: .generalMember, in: memberPayments, messageWhenNotExists: "TODO: パーティメンバーに一般がいなかったら、「調整先に一般」を選択できないようにする。")
    }
}

/// ［アジャスター］ランダムに選択された1人に対して調整
struct RandomSacrificedAdjuster: DifferenceAdjuster {

    func adjust(_ difference: DifferenceAmount, in memberPayments: MemberPayments) -> MemberPayments {
        memberPayments.changingPaymentAmountRandomly(additionalAmount: difference)
    }
}



fileprivate func _adjust(_ difference: DifferenceAmount, to memberType: MemberType, in memberPayments: MemberPayments, messageWhenNotExists message: String) -> MemberPayments {

    let adjusted = _adjust(difference, in: memberPayments, where: _predicate(for: memberType))

    guard let adjustedMemberPayment = adjusted else {
        fatalError(message)
    }

    return memberPayments.replacing(memberPayment: adjustedMemberPayment)
}

fileprivate func _adjust(_ difference: DifferenceAmount, in memberPayments: MemberPayments, where predicate: KeyPath<Member, Bool>) -> MemberPayment? {

    return memberPayments
            .filter() { $0.member[keyPath: predicate] }
            .shuffled()
            .first
            .map() { $0.addingPaymentAmount(difference) }
}

fileprivate func _predicate(for memberType: MemberType) -> KeyPath<Member, Bool> {

    switch memberType {
        case .partyOrganizer: return \.isPartyOrganizer
        case .secretary:      return \.isSecretary
        case .generalMember:  return \.isGeneralMember
    }
}
