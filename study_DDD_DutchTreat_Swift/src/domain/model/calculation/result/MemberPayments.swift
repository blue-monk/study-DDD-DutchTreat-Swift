//
//  MemberPayments.swift
//  study_DDD_DutchTreat_Swift
//
//  Created by blue-monk on 2020/01/26.
//  Copyright © 2020 blue-monk. All rights reserved.
//

import Foundation

struct MemberPayments {

    private let _rawMemberPayments: [MemberPayment]
    private let _billingAmount: BillingAmount
}

//MARK: 初期化
extension MemberPayments {

    init(rawMemberPayments: [MemberPayment], billingAmount: BillingAmount) {

        guard !rawMemberPayments.isEmpty else {
            fatalError("rawMemberPaymentsが空っぽ")
        }

        _rawMemberPayments = rawMemberPayments
        _billingAmount = billingAmount
    }
}

//MARK: 計算
extension MemberPayments {

    func differenceFromBillingAmount() -> DifferenceAmount {
        _billingAmount - _totalPaymentAmount();
    }

    private func _totalPaymentAmount() -> TotalPaymentAmount {

        let total = _rawMemberPayments
                .map { $0.paymentAmount }
                .sum(in: _billingAmount.currency)

        return TotalPaymentAmount(money: total.money)
    }
}

//MARK: 位置算出
extension MemberPayments {

    private func _index(of memberPayment: MemberPayment) -> Int {

        //guard let index = _rawMemberPayments.firstIndex(where: { $0.member == memberPayment.member }) else {    //THINK: member の等値性で判定。amount は既に調整済みなので異なる。
        guard let index = _rawMemberPayments.firstIndex(where: { $0.id == memberPayment.id }) else {        //THINK: 位置の場合、同一性で判定すべきかな？ member の name重複チェックはやっているとは言え... id があるやつは Entiry？
            fatalError("指定された memberPayment が memberPayments に存在しない [memberPayment=\(memberPayment), memberPayments=\(self)]")
        }
        return index
    }

    private func _range(of memberPayment: MemberPayment) -> Range<Int> {

        let index = _index(of: memberPayment)
        return index..<index + 1
    }
}

//MARK: 内包する MemberPayment を置き換え（non-mutating）
extension MemberPayments {

    func replacing(memberPayment: MemberPayment) -> Self {

        var rawMemberPayments = _rawMemberPayments
        let range = _range(of: memberPayment)
        rawMemberPayments.replaceSubrange(range, with: [memberPayment])

        return MemberPayments(rawMemberPayments: rawMemberPayments, billingAmount: _billingAmount)
    }
}

//MARK: ランダムに選択された MemberPayment
extension MemberPayments {

    func randomMemberPayment() -> MemberPayment {
        _rawMemberPayments.randomElement()!         //NOTE: 必ず主催者はいる
    }
}

//MARK: Sequence 準拠
extension MemberPayments: Sequence {

    func makeIterator() -> MemberPaymentIterator {
        return MemberPaymentIterator(memberPayments: _rawMemberPayments)
    }
}

//MARK: イテレータ
struct MemberPaymentIterator: IteratorProtocol {

    var memberPayments: [MemberPayment]

    mutating func next() -> MemberPayment? {
        memberPayments.isEmpty ? nil : memberPayments.removeFirst()
    }
}



extension MemberPayments: CustomDebugStringConvertible {

    var debugDescription: String {
        
        var text = ""

        _rawMemberPayments.forEach { (mp) in
            text.append(mp.debugDescription)
            text.append("\n")
        }
        return text
    }
}
