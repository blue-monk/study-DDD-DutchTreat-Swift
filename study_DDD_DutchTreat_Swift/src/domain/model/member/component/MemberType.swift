//
//  MemberType.swift
//  study_DDD_DutchTreat_Swift
//
//  Created by blue-monk on 2020/01/26.
//  Copyright © 2020 blue-monk. All rights reserved.
//

import Foundation

enum MemberType: String, CaseIterable {

    case partyOrganizer
    case secretary
    case generalMember

    private struct Const {
        let memberType: MemberType
        let displayName: String
    }

    private static let _constants = EnumMap<MemberType, Const> { type in
        switch type {
            case .partyOrganizer: return Const(memberType: partyOrganizer, displayName: "主催者")
            case .secretary:      return Const(memberType: secretary, displayName: "幹事")
            case .generalMember:  return Const(memberType: generalMember, displayName: "一般参加者")
        }
    }
}

//MARK: タイプ判定
extension MemberType {

    func isPartyOrganizer() -> Bool {
        self == .partyOrganizer
    }

    func isSecretary() -> Bool {
        self == .secretary
    }

    func isGeneralMember() -> Bool {
        self == .generalMember
    }
}

//MARK: 属性
extension MemberType {

    func displayName() -> String {
        MemberType._constants[self].displayName
    }
}



extension MemberType: CustomDebugStringConvertible {

    var debugDescription: String {
        debugString(subject: self, value: rawValue)
    }
}
