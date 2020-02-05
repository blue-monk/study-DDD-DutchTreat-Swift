//
//  DrinkingParty.swift
//  study_DDD_DutchTreat_Swift
//
//  Created by blue-monk on 2020/01/26.
//  Copyright © 2020 blue-monk. All rights reserved.
//

import Foundation

struct DrinkingParty {

    var partyName: PartyName
    var holdDateTime: HoldDateTime

    var organizer: Organizer {
        didSet {
            _partyMembers.change(organizer: organizer)
        }
    }

    private var _partyMembers: PartyMembers
}

//MARK: 初期化
extension DrinkingParty {

    init(partyName: PartyName, holdDateTime: HoldDateTime, organizer: Organizer) throws {

        self.partyName = partyName
        self.holdDateTime = holdDateTime
        self.organizer = organizer
        _partyMembers = PartyMembers(organizer)
    }
}

//MARK: メンバー増減（mutating）
extension DrinkingParty {

    mutating func add(member: Member) throws {
        try _partyMembers.append(member)
    }

    mutating func remove(member: Member) {
        _partyMembers.remove(member)
    }
}

//MARK: 割り勘
extension DrinkingParty {

    func splitBill(_ billingAmount: BillingAmount,
                   _ paymentLevelSpecifics: PaymentLevelSpecifics,
                   _ specifiedRounding: SpecifiedRounding,
                   _ differenceAdjustmentPolicy: DifferenceAdjustmentPolicy = DifferenceAdjustmentPolicy.assignToOrganizer
    ) -> MemberPayments {

        let calculator = DutchTreatCalculator(billingAmount, paymentLevelSpecifics, _partyMembers, specifiedRounding, differenceAdjustmentPolicy)
        return calculator.splitBill()
    }
}


//MARK: テストサポート
extension DrinkingParty {

    func contains(organizer: Organizer) -> Bool {
        _partyMembers.contains(organizer.substance)
    }

    func notContains(organizer: Organizer) -> Bool {
        !contains(organizer: organizer)
    }

    func contains(member: Member) -> Bool {
        _partyMembers.contains(member)
    }

    func notContains(member: Member) -> Bool {
        !contains(member: member)
    }
}



extension DrinkingParty: CustomDebugStringConvertible {

    var debugDescription: String {
        debugString(subject: self, value1: partyName, value2: holdDateTime, value3: organizer, value4: _partyMembers)
    }
}

