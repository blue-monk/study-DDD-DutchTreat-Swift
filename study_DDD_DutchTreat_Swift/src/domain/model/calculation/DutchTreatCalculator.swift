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

    //MARK: 初期化
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

        let paymentAmountsByLevel = _computedPaymentAmountsByLevel()

        let memberPayments = partyMembers.map() { member -> MemberPayment in
            let appliedPaymentAmount = paymentAmountsByLevel[member.paymentLevel]!                  //NOTE: 計算済みの金額を適用するだけ
            return MemberPayment(member: member, paymentAmount: appliedPaymentAmount)
        }

        return _adjustDifference(in: MemberPayments(rawMemberPayments: memberPayments, billingAmount: billingAmount))
    }

    //MARK: 割り勘計算
    private func _computedPaymentAmountsByLevel() -> [PaymentLevel: PaymentAmount] {

        let weightsByLevel = paymentLevelSpecifics.weightsByLevel
        let totalWeight = partyMembers.totalWeight(with: paymentLevelSpecifics);

        let levelAndPayment = weightsByLevel.map() { level, weight in
                (level, (billingAmount * weight / totalWeight).rounded(by: specifiedRounding)) }    //SPEC: 割り勘の計算式

        return Dictionary(uniqueKeysWithValues: levelAndPayment)
    }

    //MARK: 差額調整
    private func _adjustDifference(in memberPayments: MemberPayments) -> MemberPayments {

        let difference = memberPayments.differenceFromBillingAmount()
        if difference.isZero() {
            return memberPayments;
        }

        return differenceAdjustmentPolicy.adjust(difference, in: memberPayments)
    }
}
