//
//  DutchTreatCalculatorTest.swift
//  study_DDD_DutchTreat_SwiftTests
//
//  Created by blue-monk on 2020/01/26.
//  Copyright © 2020 blue-monk. All rights reserved.
//

import XCTest
@testable import study_DDD_DutchTreat_Swift

class DrinkingPartyTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    //MARK: 因子
    struct Factor : TestDataSeed, CustomDebugStringConvertible {

        typealias T = (DrinkingParty, BillingAmount, PaymentLevelSpecifics, SpecifiedRounding, DifferenceAdjustmentPolicy)

        let caseNo: Int
        let member構成: DrinkingParty.メンバー構成
        let paymentLevelVariation: PaymentLevelSpecifics.Variation
        let billingAmount: Decimal
        let billingCurrency: Currency
        let roundingUnit: RoundingUnit
        let rounding: Rounding
        let differenceAdjustmentPolicy: DifferenceAdjustmentPolicy

        init(_ caseNo: Int,
             _ member構成: DrinkingParty.メンバー構成, _ paymentLevelSpecifics: PaymentLevelSpecifics.Variation,
             billingAmount: Decimal, _ billingCurrency: Currency, _ roundingUnit: RoundingUnit, _ rounding: Rounding, _ differenceAdjustmentPolicy: DifferenceAdjustmentPolicy
        ) {
            self.caseNo = caseNo
            self.member構成 = member構成
            self.paymentLevelVariation = paymentLevelSpecifics
            self.billingAmount = billingAmount
            self.billingCurrency = billingCurrency
            self.roundingUnit = roundingUnit
            self.rounding = rounding
            self.differenceAdjustmentPolicy = differenceAdjustmentPolicy
        }

        func makeInputData() -> T {

            let party = member構成.drinkingParty()
            return (party,
                    BillingAmount(billingAmount, currency: billingCurrency),
                    paymentLevelVariation.paymentLevelSpecifics(),
                    SpecifiedRounding(roundingUnit: roundingUnit, rounding: rounding),
                    differenceAdjustmentPolicy)
        }

        var debugDescription: String {
            return debugString(subject: self, value1: member構成, value2: paymentLevelVariation, value3: billingAmount, value4: billingCurrency, value5: roundingUnit, value6: rounding, value7: differenceAdjustmentPolicy)
        }
    }

    //MARK: 期待値
    struct Expected: CustomDebugStringConvertible {

        struct Apportionment {
            let more: Decimal
            let std: Decimal
            let less: Decimal
        }

        enum AdjustedMember {
            case 主催者
            case 幹事
            case 一般
            case any

            func memberType() -> MemberType? {
                switch self {
                    case .主催者: return MemberType.partyOrganizer
                    case .幹事:  return MemberType.secretary
                    case .一般:  return MemberType.generalMember
                    case .any:  return .none
                }
            }
        }

        let apportionment: Apportionment
        let paymentAmountOfMore: PaymentAmount
        let paymentAmountOfStd: PaymentAmount
        let paymentAmountOfLess: PaymentAmount

        let adjustedMember: AdjustedMember
        let adjustedAmount: PaymentAmount
        let currency: Currency

        let note: String

        init(splitInto paymentAmounts: Apportionment, adjustedTo adjustedMember: AdjustedMember, _ adjustedAmount: Decimal, _ currency: Currency, note: String = "") {

            self.apportionment = paymentAmounts
            self.paymentAmountOfMore = PaymentAmount(paymentAmounts.more, currency: currency)
            self.paymentAmountOfStd = PaymentAmount(paymentAmounts.std, currency: currency)
            self.paymentAmountOfLess = PaymentAmount(paymentAmounts.less, currency: currency)

            self.adjustedMember = adjustedMember
            self.adjustedAmount = PaymentAmount(adjustedAmount, currency: currency)
            self.currency = currency

            self.note = note
        }
        
        var adjustedPaymentAmountForMore: PaymentAmount {
            paymentAmountOfMore + adjustedAmount
        }

        var adjustedPaymentAmountForStd: PaymentAmount {
            paymentAmountOfStd + adjustedAmount
        }

        var adjustedPaymentAmountForLess: PaymentAmount {
            paymentAmountOfLess + adjustedAmount
        }

        var debugDescription: String {
            return debugString(subject: self, value1: apportionment, value2: "調整先=\(adjustedMember)", value3: adjustedAmount)
        }
    }



    // テストケース
    struct 割り勘計算 : TestCaseProvider {

        static func cases() -> [(DrinkingPartyTest.Factor, expect: DrinkingPartyTest.Expected)] {
            割り勘計算()._cases
        }
        
        typealias Ap = Expected.Apportionment
        private let _cases = [

            //NOTE: 主催者は必ず1人いる

            // 全て同値
            (Factor(101, .幹事1_一般3, .全て同値, billingAmount: Decimal(1),      .JPY, .default, .harfUp, .assignToOrganizer), Expected(splitInto: Ap(more: 0, std: 0, less: 0),             adjustedTo: .主催者, Decimal(1),    .JPY, note: "最少額, 差額のみ, 円")),
            (Factor(102, .幹事1_一般3, .全て同値, billingAmount: Decimal(0.01),   .USD, .default, .harfUp, .assignToOrganizer), Expected(splitInto: Ap(more: 0, std: 0, less: 0),             adjustedTo: .主催者, Decimal(0.01), .USD, note: "最少額, 差額のみ, ドル")),

            (Factor(103, .幹事1_一般3, .全て同値, billingAmount: Decimal(1725),   .JPY, .default, .harfUp, .assignToOrganizer), Expected(splitInto: Ap(more: 345, std: 345, less: 345),       adjustedTo: .主催者, Decimal(0),    .JPY, note: "1円単位, 調整なし")),
            (Factor(104, .幹事1_一般3, .全て同値, billingAmount: Decimal(117.25), .USD, .default, .harfUp, .assignToOrganizer), Expected(splitInto: Ap(more: 23.45, std: 23.45, less: 23.45), adjustedTo: .主催者, Decimal(0),    .USD, note: "1セント単位, 調整なし")),

            (Factor(105, .幹事1_一般3, .全て同値, billingAmount: Decimal(1726),   .JPY, .default, .harfUp, .assignToOrganizer), Expected(splitInto: Ap(more: 345, std: 345, less: 345),       adjustedTo: .主催者, Decimal(1),    .JPY, note: "1円単位, 調整あり")),
            (Factor(106, .幹事1_一般3, .全て同値, billingAmount: Decimal(117.26), .USD, .default, .harfUp, .assignToOrganizer), Expected(splitInto: Ap(more: 23.45, std: 23.45, less: 23.45), adjustedTo: .主催者, Decimal(0.01), .USD, note: "1セント単位, 調整あり")),

            (Factor(107, .幹事1_一般3, .全て同値, billingAmount: Decimal(1771),   .JPY, .default, .harfUp, .assignToOrganizer), Expected(splitInto: Ap(more: 354, std: 354, less: 354),       adjustedTo: .主催者, Decimal(1),    .JPY, note: "1円単位, 調整あり")),
            (Factor(108, .幹事1_一般3, .全て同値, billingAmount: Decimal(117.71), .USD, .default, .harfUp, .assignToOrganizer), Expected(splitInto: Ap(more: 23.54, std: 23.54, less: 23.54), adjustedTo: .主催者, Decimal(0.01), .USD, note: "1セント単位, 調整あり")),

            (Factor(201, .幹事1_一般3, .全て同値, billingAmount: Decimal(100),    .JPY, .hundred, .harfUp, .assignToOrganizer), Expected(splitInto: Ap(more: 0, std: 0, less: 0),             adjustedTo: .主催者, Decimal(100),  .JPY, note: "差額のみ")),
            (Factor(202, .幹事1_一般3, .全て同値, billingAmount: Decimal(1725),   .JPY, .hundred, .harfUp, .assignToOrganizer), Expected(splitInto: Ap(more: 300, std: 300, less: 300),       adjustedTo: .主催者, Decimal(225),  .JPY, note: "100円単位での四捨五入(捨), 差額なし")),
            (Factor(203, .幹事1_一般3, .全て同値, billingAmount: Decimal(1726),   .JPY, .hundred, .harfUp, .assignToOrganizer), Expected(splitInto: Ap(more: 300, std: 300, less: 300),       adjustedTo: .主催者, Decimal(226),  .JPY, note: "100円単位での四捨五入(捨), 差額あり")),
            (Factor(204, .幹事1_一般3, .全て同値, billingAmount: Decimal(1770),   .JPY, .hundred, .harfUp, .assignToOrganizer), Expected(splitInto: Ap(more: 400, std: 400, less: 400),       adjustedTo: .主催者, Decimal(-230), .JPY, note: "100円単位での四捨五入(入), 差額なし")),
            (Factor(205, .幹事1_一般3, .全て同値, billingAmount: Decimal(1771),   .JPY, .hundred, .harfUp, .assignToOrganizer), Expected(splitInto: Ap(more: 400, std: 400, less: 400),       adjustedTo: .主催者, Decimal(-229), .JPY, note: "100円単位での四捨五入(入), 差額あり")),

            // 全て異値
            (Factor(501, .幹事1_一般3, .全て異値(more: 5, std: 3, less: 2), billingAmount: Decimal(16581), .JPY, .default,  .harfUp, .assignToOrganizer),      Expected(splitInto: .init(more: 4606, std: 2764, less: 1842),    adjustedTo: .主催者, Decimal(-1),    .JPY, note: "1円単位")),
            (Factor(502, .幹事1_一般3, .全て異値(more: 5, std: 3, less: 2), billingAmount: Decimal(16581), .JPY, .ten,      .harfUp, .assignToOrganizer),      Expected(splitInto: .init(more: 4610, std: 2760, less: 1840),    adjustedTo: .主催者, Decimal(1),     .JPY, note: "10円単位")),
            (Factor(503, .幹事1_一般3, .全て異値(more: 5, std: 3, less: 2), billingAmount: Decimal(16581), .JPY, .hundred,  .harfUp, .assignToOrganizer),      Expected(splitInto: .init(more: 4600, std: 2800, less: 1800),    adjustedTo: .主催者, Decimal(-19),   .JPY, note: "100円単位")),

            (Factor(511, .幹事1_一般3, .全て異値(more: 5, std: 3, less: 2), billingAmount: Decimal(165.81), .USD, .default, .harfUp, .assignToOrganizer),      Expected(splitInto: .init(more: 46.06, std: 27.64, less: 18.42), adjustedTo: .主催者, Decimal(-0.01), .USD, note: "1セント単位")),
            (Factor(512, .幹事1_一般3, .全て異値(more: 5, std: 3, less: 2), billingAmount: Decimal(165.81), .USD, .ten,     .harfUp, .assignToOrganizer),      Expected(splitInto: .init(more: 46.10, std: 27.60, less: 18.40), adjustedTo: .主催者, Decimal(0.01),  .USD, note: "10セント単位")),
            (Factor(513, .幹事1_一般3, .全て異値(more: 5, std: 3, less: 2), billingAmount: Decimal(165.81), .USD, .hundred, .harfUp, .assignToOrganizer),      Expected(splitInto: .init(more: 46.00, std: 28.00, less: 18.00), adjustedTo: .主催者, Decimal(-0.19), .USD, note: "100セント単位")),

            (Factor(601, .幹事3_一般5, .全て異値(more: 5, std: 3, less: 1), billingAmount: Decimal(75839), .JPY, .default,  .harfUp, .assignToOrganizer),      Expected(splitInto: .init(more: 13076, std: 7845, less: 2615),   adjustedTo: .主催者, Decimal(1),     .JPY, note: "1円単位")),
            (Factor(602, .幹事3_一般5, .全て異値(more: 5, std: 3, less: 1), billingAmount: Decimal(75839), .JPY, .ten,      .harfUp, .assignToOrganizer),      Expected(splitInto: .init(more: 13080, std: 7850, less: 2620),   adjustedTo: .主催者, Decimal(-41),   .JPY, note: "10円単位")),
            (Factor(603, .幹事3_一般5, .全て異値(more: 5, std: 3, less: 1), billingAmount: Decimal(75839), .JPY, .hundred,  .harfUp, .assignToOrganizer),      Expected(splitInto: .init(more: 13100, std: 7800, less: 2600),   adjustedTo: .主催者, Decimal(139),   .JPY, note: "100円単位")),

            (Factor(601, .幹事3_一般5, .全て異値(more: 5, std: 3, less: 1), billingAmount: Decimal(75839), .JPY, .default,  .harfUp, .assignToOneOfSecretary), Expected(splitInto: .init(more: 13076, std: 7845, less: 2615),   adjustedTo: .幹事, Decimal(1),       .JPY, note: "1円単位")),
            (Factor(602, .幹事3_一般5, .全て異値(more: 5, std: 3, less: 1), billingAmount: Decimal(75839), .JPY, .ten,      .harfUp, .assignToOneOfSecretary), Expected(splitInto: .init(more: 13080, std: 7850, less: 2620),   adjustedTo: .幹事, Decimal(-41),     .JPY, note: "10円単位")),
            (Factor(603, .幹事3_一般5, .全て異値(more: 5, std: 3, less: 1), billingAmount: Decimal(75839), .JPY, .hundred,  .harfUp, .assignToOneOfSecretary), Expected(splitInto: .init(more: 13100, std: 7800, less: 2600),   adjustedTo: .幹事, Decimal(139),     .JPY, note: "100円単位")),

            (Factor(611, .幹事3_一般5, .全て異値(more: 5, std: 3, less: 1), billingAmount: Decimal(75839), .JPY, .default,  .harfUp, .assignToOneOfGenaral),   Expected(splitInto: .init(more: 13076, std: 7845, less: 2615),   adjustedTo: .一般, Decimal(1),       .JPY, note: "1円単位")),
            (Factor(612, .幹事3_一般5, .全て異値(more: 5, std: 3, less: 1), billingAmount: Decimal(75839), .JPY, .ten,      .harfUp, .assignToOneOfGenaral),   Expected(splitInto: .init(more: 13080, std: 7850, less: 2620),   adjustedTo: .一般, Decimal(-41),     .JPY, note: "10円単位")),
            (Factor(613, .幹事3_一般5, .全て異値(more: 5, std: 3, less: 1), billingAmount: Decimal(75839), .JPY, .hundred,  .harfUp, .assignToOneOfGenaral),   Expected(splitInto: .init(more: 13100, std: 7800, less: 2600),   adjustedTo: .一般, Decimal(139),     .JPY, note: "100円単位")),

            (Factor(621, .幹事3_一般5, .全て異値(more: 5, std: 3, less: 1), billingAmount: Decimal(75839), .JPY, .default,  .harfUp, .assignRandomly),         Expected(splitInto: .init(more: 13076, std: 7845, less: 2615),   adjustedTo: .any, Decimal(1),       .JPY, note: "1円単位")),
            (Factor(622, .幹事3_一般5, .全て異値(more: 5, std: 3, less: 1), billingAmount: Decimal(75839), .JPY, .ten,      .harfUp, .assignRandomly),         Expected(splitInto: .init(more: 13080, std: 7850, less: 2620),   adjustedTo: .any, Decimal(-41),     .JPY, note: "10円単位")),
            (Factor(623, .幹事3_一般5, .全て異値(more: 5, std: 3, less: 1), billingAmount: Decimal(75839), .JPY, .hundred,  .harfUp, .assignRandomly),         Expected(splitInto: .init(more: 13100, std: 7800, less: 2600),   adjustedTo: .any, Decimal(139),     .JPY, note: "100円単位")),

            //TODO: more
        ]
    }


    func test_割り勘計算() throws {

        trace()

        割り勘計算.cases().forEach { (factor, expected) in

            print("\n======== case-\(factor.caseNo) \(expected.note) ========")
            print(factor)

            /* セットアップ */
            let (drinkingParty, billingAmount, paymentLevelSpecifics, specifiedRounding, differenceAdjustmentPolicy) = factor.makeInputData()

            /* 実行 */
            let memberPayments = drinkingParty.splitBill(billingAmount, paymentLevelSpecifics, specifiedRounding, differenceAdjustmentPolicy)

            /* 検証 */
            print("actual=\n\(memberPayments)")
            print("expected=\(expected)")

            XCTAssertTrue(memberPayments.differenceFromBillingAmount().isZero(), "支払総額が請求金額と同じになっていること")

            memberPayments.forEach { (actual) in

                if let expectedAdjustmentDestination = expected.adjustedMember.memberType() {       // ◇調整先がメンバータイプのいずれかに決まっている場合（主催者/幹事/一般）

                    if actual.member.memberType == expectedAdjustmentDestination {

                        let (bool, message) = expected.isSameAmountUnderDestination(actual)           //     ◆調整先の場合
                        XCTAssertTrue(bool, message)
                    }
                    else {
                        let (bool, message) = expected.isSameAmountUnderNotDestination(actual)        //     ◆調整先ではない場合
                        XCTAssertTrue(bool, message)
                    }
                }
                else {                                                                              // ◇調整先がランダムの場合
                    let (bool, message) = expected.isSameAmountUnderCaseOfRandom(actual)
                    XCTAssertTrue(bool, message)
                }
            }
        }
    }

    func test_主催者変更() throws {

        trace()

        /* セットアップ */
        let oldOrganizer = Organizer.fixture(name: "主催者A", paymentLevel: .less)
        var party = DrinkingParty.fixture(organizer: oldOrganizer)
        print("before party=\(party)")

        /* 実行 */
        let newOrganizer = Organizer.fixture(name: "主催者B", paymentLevel: .more)
        party.organizer = newOrganizer

        /* 検証 */
        print("afer party=\(party)")
        XCTAssertEqual(party.organizer, newOrganizer)
        XCTAssertNotEqual(party.organizer, oldOrganizer)
        XCTAssertTrue(party.contains(organizer: newOrganizer))
        XCTAssertTrue(party.notContains(organizer: oldOrganizer))
    }

    func test_メンバー増減() throws {

        trace()

        /* セットアップ */
        var party = DrinkingParty.fixture()
        print("initial party=\(party)")

        /* 実行 */
        let secretaryA = Member.fixtureOfSecretary(memberName: "幹事A", paymentLevel: .less)
        let secretaryB = Member.fixtureOfSecretary(memberName: "幹事B", paymentLevel: .more)
        let secretaryC = Member.fixtureOfSecretary(memberName: "幹事C", paymentLevel: .standard)
        let generalA = Member.fixtureOfGeneral(memberName: "一般A", paymentLevel: .more)
        let generalB = Member.fixtureOfGeneral(memberName: "一般B", paymentLevel: .standard)
        let generalC = Member.fixtureOfGeneral(memberName: "一般C", paymentLevel: .less)

        try! party.add(member: secretaryA)
        try! party.add(member: secretaryB)
        try! party.add(member: secretaryC)
        try! party.add(member: generalA)
        try! party.add(member: generalB)
        try! party.add(member: generalC)

        print("afer added 6members party=\(party)")
        XCTAssertEqual(party.organizer, Organizer.fixture())
        XCTAssertTrue(party.contains(member: secretaryA))
        XCTAssertTrue(party.contains(member: secretaryB))
        XCTAssertTrue(party.contains(member: secretaryC))
        XCTAssertTrue(party.contains(member: generalA))
        XCTAssertTrue(party.contains(member: generalB))
        XCTAssertTrue(party.contains(member: generalC))

        party.remove(member: secretaryA)
        party.remove(member: secretaryC)
        party.remove(member: generalB)

        print("afer removed 3members party=\(party)")
        XCTAssertEqual(party.organizer, Organizer.fixture())
        XCTAssertTrue(party.notContains(member: secretaryA))
        XCTAssertTrue(party.contains(member: secretaryB))
        XCTAssertTrue(party.notContains(member: secretaryC))
        XCTAssertTrue(party.contains(member: generalA))
        XCTAssertTrue(party.notContains(member: generalB))
        XCTAssertTrue(party.contains(member: generalC))
    }

    func test_同じ名前のメンバー追加したらエラー() {

        trace()

        /* セットアップ */
        var party = DrinkingParty.fixture()
        let secretaryA = Member.fixtureOfSecretary(memberName: "幹事A", paymentLevel: .less)
        try! party.add(member: secretaryA)
        let secretaryB = Member.fixtureOfSecretary(memberName: "幹事B", paymentLevel: .more)
        try! party.add(member: secretaryB)
        let generalA = Member.fixtureOfGeneral(memberName: "一般メンバーA", paymentLevel: .standard)
        try! party.add(member: generalA)
        let generalB = Member.fixtureOfGeneral(memberName: "一般メンバーB", paymentLevel: .less)
        try! party.add(member: generalB)
        print("initial party=\(party)")

        /* 実行&検証 */
        XCTAssertThrowsError(try party.add(member: secretaryA), "既存を追加するとエラー") { error in
            XCTAssertEqual(error as! DomainError, DomainError.invalid(message: "同じ名前のメンバーが存在します."))
        }

        let dupe1 = Member.fixtureOfSecretary(memberName: "幹事B", paymentLevel: .more)
        XCTAssertThrowsError(try party.add(member: dupe1), "同名の新しいメンバーを追加するとエラー") { error in
            XCTAssertEqual(error as! DomainError, DomainError.invalid(message: "同じ名前のメンバーが存在します."))
        }

        let dupe2 = Member.fixtureOfSecretary(memberName: "一般メンバーA", paymentLevel: .more)
        XCTAssertThrowsError(try party.add(member: dupe2), "同名の新しいメンバーを追加するとエラー") { error in
            XCTAssertEqual(error as! DomainError, DomainError.invalid(message: "同じ名前のメンバーが存在します."))
        }

        let dupe3 = Member.fixtureOfSecretary(memberName: "幹事A", paymentLevel: .more)
        XCTAssertThrowsError(try party.add(member: dupe3), "同名の新しいメンバーを追加するとエラー") { error in
            XCTAssertEqual(error as! DomainError, DomainError.invalid(message: "同じ名前のメンバーが存在します."))
        }

        let dupe4 = Member.fixtureOfSecretary(memberName: "一般メンバーB", paymentLevel: .more)
        XCTAssertThrowsError(try party.add(member: dupe4), "同名の新しいメンバーを追加するとエラー") { error in
            XCTAssertEqual(error as! DomainError, DomainError.invalid(message: "同じ名前のメンバーが存在します."))
        }
    }



    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}


//MARK: アサーションサポート
extension DrinkingPartyTest.Expected {

    func isSameAmountUnderDestination(_ actual: MemberPayment) -> (Bool, message: String) {

        let actualAmount = actual.paymentAmount

        if actual.member.isPartyOrganizer {
            let baseMessage = "支払レベルに応じた支払額+調整額になっていること"
            switch actual.member.paymentLevel {
                case .more:     return (actualAmount == adjustedPaymentAmountForMore, baseMessage + "(more + adjusted): actualAmount=\(actualAmount), expected.more=\(apportionment.more), adjustedAmount=\(adjustedAmount)")
                case .standard: return (actualAmount == adjustedPaymentAmountForStd, baseMessage + "(standard + adjusted): actualAmount=\(actualAmount), expected.more=\(apportionment.more), adjustedAmount=\(adjustedAmount)")
                case .less:     return (actualAmount == adjustedPaymentAmountForLess, baseMessage + "(less + adjusted): actualAmount=\(actualAmount), expected.more=\(apportionment.more), adjustedAmount=\(adjustedAmount)")
            }
        }
        else {
            return amountOrAdjustmentMatches(with: actual)
        }
    }

    func isSameAmountUnderNotDestination(_ actual: MemberPayment) -> (Bool, message: String) {

        let actualAmount = actual.paymentAmount

        let baseMessage = "支払レベルに応じた支払額になっていること"
        switch actual.member.paymentLevel {
            case .more:     return (actualAmount == paymentAmountOfMore, baseMessage + "(more): actualAmount=\(actualAmount), expected.more=\(paymentAmountOfMore)")
            case .standard: return (actualAmount == paymentAmountOfStd, baseMessage + "(standard): actualAmount=\(actualAmount), expected.std=\(paymentAmountOfStd)")
            case .less:     return (actualAmount == paymentAmountOfLess, baseMessage + "(less): actualAmount=\(actualAmount), expected.less=\(paymentAmountOfLess)")
        }
    }

    func isSameAmountUnderCaseOfRandom(_ actual: MemberPayment) -> (Bool, message: String) {
        amountOrAdjustmentMatches(with: actual)
    }

    private func amountOrAdjustmentMatches(with actual: MemberPayment) -> (Bool, message: String) {

        let actualAmount = actual.paymentAmount

        let baseMessage = "支払レベルに応じた支払額、または調整額を加算した額になっていること"
        switch actual.member.paymentLevel {
            case .more:
                let message = baseMessage + "(more | more + adjusted): actualAmount=\(actualAmount), expected.more=\(apportionment.more), adjustedAmount=\(adjustedAmount)"
                if actualAmount == adjustedPaymentAmountForMore {
                    return (true, message)
                }
                return actualAmount == paymentAmountOfMore ? (true, message) : (false, message)
            case .standard:
                let message = baseMessage + "(standard | standard + adjusted): actualAmount=\(actualAmount), expected.std=\(apportionment.std), adjustedAmount=\(adjustedAmount)"
                if actualAmount == adjustedPaymentAmountForStd {
                    return (true, message)
                }
                return actualAmount == paymentAmountOfStd ? (true, message) : (false, message)
            case .less:
                let message = baseMessage + "(less | less + adjusted): actualAmount=\(actualAmount), expected.less=\(apportionment.less), adjustedAmount=\(adjustedAmount)"
                if actualAmount == adjustedPaymentAmountForLess {
                    return (true, message)
                }
                return actualAmount == paymentAmountOfLess ? (true, message) : (false, message)
        }
    }
}
