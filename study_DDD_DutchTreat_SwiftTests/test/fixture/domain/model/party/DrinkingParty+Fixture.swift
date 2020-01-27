//
//  DrinkingParty+Fixture.swift
//  study_DDD_DutchTreat_SwiftTests
//
//  Created by blue-monk on 2020/01/26.
//  Copyright © 2020 blue-monk. All rights reserved.
//

import Foundation
@testable import study_DDD_DutchTreat_Swift

extension DrinkingParty {

    static func fixture(partyName: PartyName = PartyName.fixture(),
                        holdDateTime: HoldDateTime = HoldDateTime.fixture(),
                        organizer: Organizer = Organizer.fixture()) -> DrinkingParty {

        try! DrinkingParty(partyName: partyName, holdDateTime: holdDateTime, organizer: organizer)
    }

    enum メンバー構成 {

        case 幹事1_一般3
        case 幹事1_一般11
        case 幹事2_一般8
        case 幹事2_一般11
        case 幹事3_一般3
        case 幹事3_一般5
        case 幹事3_一般8
        case 幹事3_一般11

        func drinkingParty() -> DrinkingParty {

            var party = DrinkingParty.fixture()

            switch self {
                case .幹事1_一般3:  return メンバー構成.setupMemberFor幹事1_一般3(into: &party)
                case .幹事1_一般11: return メンバー構成.setupMemberFor幹事1_一般11(into: &party)
                case .幹事2_一般8:  return メンバー構成.setupMemberFor幹事2_一般8(into: &party)
                case .幹事2_一般11: return メンバー構成.setupMemberFor幹事2_一般11(into: &party)
                case .幹事3_一般3:  return メンバー構成.setupMemberFor幹事3_一般3(into: &party)
                case .幹事3_一般5:  return メンバー構成.setupMemberFor幹事3_一般5(into: &party)
                case .幹事3_一般8:  return メンバー構成.setupMemberFor幹事3_一般8(into: &party)
                case .幹事3_一般11: return メンバー構成.setupMemberFor幹事3_一般11(into: &party)
            }
        }

        private static func setupMemberFor幹事1_一般3(into party: inout DrinkingParty) -> DrinkingParty {       //NOTE: 今のところ、Partyは mutableにしている
            try! party.add(member: Member.fixtureOfSecretary(memberName: "幹事", paymentLevel: .standard))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般01", paymentLevel: .more))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般02", paymentLevel: .more))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般03", paymentLevel: .less))
            return party
        }

        private static func setupMemberFor幹事1_一般11(into party: inout DrinkingParty) -> DrinkingParty {
            try! party.add(member: Member.fixtureOfSecretary(memberName: "幹事", paymentLevel: .standard))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般01", paymentLevel: .standard))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般02", paymentLevel: .more))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般03", paymentLevel: .standard))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般04", paymentLevel: .standard))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般05", paymentLevel: .less))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般06", paymentLevel: .more))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般07", paymentLevel: .less))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般08", paymentLevel: .less))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般09", paymentLevel: .more))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般10", paymentLevel: .more))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般11", paymentLevel: .less))
            return party
        }

        private static func setupMemberFor幹事2_一般8(into party: inout DrinkingParty) -> DrinkingParty {
            try! party.add(member: Member.fixtureOfSecretary(memberName: "幹事1", paymentLevel: .more))
            try! party.add(member: Member.fixtureOfSecretary(memberName: "幹事2", paymentLevel: .less))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般01", paymentLevel: .more))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般02", paymentLevel: .standard))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般03", paymentLevel: .less))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般04", paymentLevel: .standard))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般05", paymentLevel: .more))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般06", paymentLevel: .standard))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般07", paymentLevel: .more))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般08", paymentLevel: .less))
            return party
        }

        private static func setupMemberFor幹事2_一般11(into party: inout DrinkingParty) -> DrinkingParty {
            try! party.add(member: Member.fixtureOfSecretary(memberName: "幹事1", paymentLevel: .less))
            try! party.add(member: Member.fixtureOfSecretary(memberName: "幹事2", paymentLevel: .less))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般01", paymentLevel: .less))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般02", paymentLevel: .standard))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般03", paymentLevel: .more))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般04", paymentLevel: .standard))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般05", paymentLevel: .more))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般06", paymentLevel: .standard))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般07", paymentLevel: .more))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般08", paymentLevel: .less))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般09", paymentLevel: .standard))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般10", paymentLevel: .more))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般11", paymentLevel: .more))
            return party
        }

        private static func setupMemberFor幹事3_一般3(into party: inout DrinkingParty) -> DrinkingParty {
            try! party.add(member: Member.fixtureOfSecretary(memberName: "幹事1", paymentLevel: .more))
            try! party.add(member: Member.fixtureOfSecretary(memberName: "幹事2", paymentLevel: .less))
            try! party.add(member: Member.fixtureOfSecretary(memberName: "幹事3", paymentLevel: .standard))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般01", paymentLevel: .more))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般02", paymentLevel: .standard))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般03", paymentLevel: .less))
            return party
        }

        private static func setupMemberFor幹事3_一般5(into party: inout DrinkingParty) -> DrinkingParty {
            try! party.add(member: Member.fixtureOfSecretary(memberName: "幹事1", paymentLevel: .less))
            try! party.add(member: Member.fixtureOfSecretary(memberName: "幹事2", paymentLevel: .standard))
            try! party.add(member: Member.fixtureOfSecretary(memberName: "幹事3", paymentLevel: .more))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般01", paymentLevel: .more))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般02", paymentLevel: .more))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般03", paymentLevel: .standard))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般04", paymentLevel: .standard))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般05", paymentLevel: .less))
            return party
        }

        private static func setupMemberFor幹事3_一般8(into party: inout DrinkingParty) -> DrinkingParty {
            try! party.add(member: Member.fixtureOfSecretary(memberName: "幹事1", paymentLevel: .more))
            try! party.add(member: Member.fixtureOfSecretary(memberName: "幹事2", paymentLevel: .more))
            try! party.add(member: Member.fixtureOfSecretary(memberName: "幹事3", paymentLevel: .standard))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般01", paymentLevel: .more))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般02", paymentLevel: .standard))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般03", paymentLevel: .standard))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般04", paymentLevel: .standard))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般05", paymentLevel: .more))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般06", paymentLevel: .more))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般07", paymentLevel: .less))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般08", paymentLevel: .more))
            return party
        }

        private static func setupMemberFor幹事3_一般11(into party: inout DrinkingParty) -> DrinkingParty {
            try! party.add(member: Member.fixtureOfSecretary(memberName: "幹事1", paymentLevel: .more))
            try! party.add(member: Member.fixtureOfSecretary(memberName: "幹事2", paymentLevel: .more))
            try! party.add(member: Member.fixtureOfSecretary(memberName: "幹事3", paymentLevel: .standard))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般01", paymentLevel: .standard))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般02", paymentLevel: .more))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般03", paymentLevel: .more))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般04", paymentLevel: .standard))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般05", paymentLevel: .more))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般06", paymentLevel: .less))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般07", paymentLevel: .standard))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般08", paymentLevel: .less))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般09", paymentLevel: .standard))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般10", paymentLevel: .less))
            try! party.add(member: Member.fixtureOfGeneral(memberName: "一般11", paymentLevel: .less))
            return party
        }
    }
}
