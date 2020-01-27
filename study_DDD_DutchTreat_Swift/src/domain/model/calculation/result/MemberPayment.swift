//
//  MemberPayment.swift
//  study_DDD_DutchTreat_Swift
//
//  Created by blue-monk on 2020/01/26.
//  Copyright © 2020 blue-monk. All rights reserved.
//

import Foundation

struct MemberPayment: Identifiable {

    let id: UUID
    let member: Member
    let paymentAmount: PaymentAmount
}

//MARK: 初期化
extension MemberPayment {

    init(member: Member, paymentAmount: PaymentAmount) {

        id = UUID()
        self.member = member
        self.paymentAmount = paymentAmount
    }
}

//MARK: 加工（non-mutating）
extension MemberPayment {

    func addingPaymentAmountIfMemberIsPartyOrganizer(additionalAmount: DifferenceAmount) -> Self {

        if member.isNotPartyOrganizer {
            return self
        }

        return MemberPayment(id: id, member: member, paymentAmount: paymentAmount + additionalAmount)
    }

    func addingPaymentAmount(_ additionalAmount: DifferenceAmount) -> Self {
        return MemberPayment(id: id, member: member, paymentAmount: paymentAmount + additionalAmount)
    }
}

//MARK: 置き換え（non-mutating）
extension MemberPayment {

    func replacing(in memberPayments: MemberPayments) -> MemberPayments {
        return memberPayments.replacing(memberPayment: self)
    }
}



extension MemberPayment: CustomDebugStringConvertible {

    var debugDescription: String {
        debugString(subject: self, value1: id, value2: member, value3: paymentAmount)
    }
}
