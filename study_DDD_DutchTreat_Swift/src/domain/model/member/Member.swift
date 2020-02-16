//
//  Member.swift
//  study_DDD_DutchTreat_Swift
//
//  Created by blue-monk on 2020/01/26.
//  Copyright © 2020 blue-monk. All rights reserved.
//

import Foundation

struct Member: PaymentLevelHolder {

    let name: MemberName
    let memberType: MemberType
    let paymentLevel: PaymentLevel
}



//MARK: タイプ判定
extension Member {

    var isPartyOrganizer: Bool {
        memberType.isPartyOrganizer()
    }

    var isNotPartyOrganizer: Bool {
        !memberType.isPartyOrganizer()
    }

    var isSecretary: Bool {
        memberType.isSecretary()
    }

    var isGeneralMember: Bool {
        memberType.isGeneralMember()
    }
}

//MARK: Equatable 準拠
extension Member: Equatable {

    static func == (lhs: Self, rhs: Self) -> Bool{
        return lhs.name == rhs.name
    }
}



extension Member: CustomDebugStringConvertible {

    var debugDescription: String {
        debugString(subject: self, value1: name, value2: memberType, value3: paymentLevel, value4: "isPartyOrganizer=\(isPartyOrganizer)")
    }
}
