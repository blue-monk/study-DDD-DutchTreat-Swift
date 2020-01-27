//
//  PartyMembers.swift
//  study_DDD_DutchTreat_Swift
//
//  Created by blue-monk on 2020/01/26.
//  Copyright © 2020 blue-monk. All rights reserved.
//

import Foundation

struct PartyMembers {

    private var members = [Member]()
}

//MARK: 初期化
extension PartyMembers {

    init(_ organizer: Organizer) {
        members.append(organizer.substance)
    }
}

//MARK: 主催者変更（mutating）
extension PartyMembers {

    mutating func change(organizer newOrganizer: Organizer) {

        members.removeAll() { $0.isPartyOrganizer }
        members.append(newOrganizer.substance)
    }
}

//MARK: メンバー増減（mutating）
extension PartyMembers {

    mutating func append(_ member: Member) throws {

        precondition(member.isNotPartyOrganizer, "主催者はこの方法では追加してはいけない.")

        guard !_existsSameName(member) else {
            throw DomainError.invalid(message: "同じ名前のメンバーが存在します.")
        }

        members.append(member)
    }

    mutating func remove(_ member: Member) {

        precondition(member.isNotPartyOrganizer, "主催者はこの方法では除去してはいけない.")

        members.removeAll() { $0 == member }
    }

    private func _existsSameName(_ member: Member) -> Bool {
        members.contains() { $0.name == member.name }
    }
}

//MARK: 計算
extension PartyMembers {

    func totalWeight(with paymentLevelSpecifics: PaymentLevelSpecifics) -> Weight {

        return members
                .map { paymentLevelSpecifics.weight(for: $0) }
                .sum()
    }
}


//MARK: Sequence 準拠
extension PartyMembers: Sequence {

    func makeIterator() -> PartyMemberIterator {
        return PartyMemberIterator(members: members)
    }
}

//MARK: イテレータ
struct PartyMemberIterator: IteratorProtocol {

    var members: [Member]

    mutating func next() -> Member? {
        members.isEmpty ? nil : members.removeFirst()
    }
}
