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
    private let _currency: Currency
}

//MARK: 初期化
extension MemberPayments {

    init(rawMemberPayments: [MemberPayment]) {

        assert(!rawMemberPayments.isEmpty, "rawMemberPaymentsが空っぽ")

        _rawMemberPayments = rawMemberPayments
        _currency = _rawMemberPayments.first!.paymentAmount.currency
    }
}

//MARK: 計算
extension MemberPayments {

    func totalPaymemtAmount() -> TotalPaymentAmount {

        let total = _rawMemberPayments
                .map { $0.paymentAmount }
                .sum()
//                .reduce(PaymentAmount.zero(currency: _currency), +)

        return TotalPaymentAmount(amountOfMoney: total.amountOfMoney)
    }
}

//MARK: Array 拡張
private extension Array where Element == PaymentAmount {

    func sum() -> Element {
        reduce(.zero(currency: currencyOnFirst()), +)
    }

    private func currencyOnFirst() -> Currency {
        first!.currency                             //TODO: 必ず要素が1つ以上存在する前提。private extension なので問題ない？
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

        return MemberPayments(rawMemberPayments: rawMemberPayments)
    }
}

//MARK: 内包する MemberPayment を変更（non-mutating）
extension MemberPayments {

    func changingPaymentAmountRandomly(additionalAmount: DifferenceAmount) -> Self {

        precondition(!_rawMemberPayments.isEmpty, "空っぽの場合は呼び出さないように制御する")

        let memberPayment = _rawMemberPayments.randomElement()!
        let changed = memberPayment.addingPaymentAmount(additionalAmount)
        return replacing(memberPayment: changed)
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