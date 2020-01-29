//
//  DutchTreatCalculator.swift
//  study_DDD_DutchTreat_Swift
//
//  Created by blue-monk on 2020/01/26.
//  Copyright © 2020 blue-monk. All rights reserved.
//

import Foundation

struct DutchTreatCalculator {

    var billingAmount: BillingAmount
    var paymentLevelSpecifics: PaymentLevelSpecifics
    var partyMembers: PartyMembers
    var specifiedRounding: SpecifiedRounding
    var differenceAdjustmentPolicy = DifferenceAdjustmentPolicy.assignToOrganizer
}

//MARK: 初期化
extension DutchTreatCalculator {

    init(_ billingAmount: BillingAmount,
         _ paymentLevelSpecifics: PaymentLevelSpecifics,
         _ partyMembers: PartyMembers,
         _ specifiedRounding: SpecifiedRounding,
         _ differenceAdjustmentPolicy: DifferenceAdjustmentPolicy = DifferenceAdjustmentPolicy.assignToOrganizer
    ) {
        self.billingAmount = billingAmount
        self.paymentLevelSpecifics = paymentLevelSpecifics
        self.partyMembers = partyMembers
        self.specifiedRounding = specifiedRounding
        self.differenceAdjustmentPolicy = differenceAdjustmentPolicy
    }
}

//MARK: 割り勘計算
extension DutchTreatCalculator {

    //MARK: 割り勘
    func splitBill() -> MemberPayments {

        let totalWeight = partyMembers.totalWeight(with: paymentLevelSpecifics);

        let memberPayments = partyMembers.map() { member -> MemberPayment in

            let weight = paymentLevelSpecifics.weight(for: member)
            let roundedAmount = (billingAmount * weight / totalWeight).rounded(by: specifiedRounding)
            return MemberPayment(member: member, paymentAmount: roundedAmount)
        }

        return adjustDifference(in: MemberPayments(rawMemberPayments: memberPayments, billingAmount: billingAmount))
    }

    //MARK: 差額調整
    func adjustDifference(in memberPayments: MemberPayments) -> MemberPayments {

        let totalPaymentAmount = memberPayments.totalPaymentAmount()

        let difference = billingAmount - totalPaymentAmount;
        if difference.isZero() {
            return memberPayments;
        }

        return differenceAdjustmentPolicy.adjust(difference, in: memberPayments)
    }
}
