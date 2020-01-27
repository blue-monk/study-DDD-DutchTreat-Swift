//
//  Organizer.swift
//  study_DDD_DutchTreat_Swift
//
//  Created by blue-monk on 2020/01/26.
//  Copyright © 2020 blue-monk. All rights reserved.
//

import Foundation

struct Organizer: Equatable {
    
    let substance: Member
}

//MARK: 初期化
extension Organizer {

    init(name: MemberName, paymentLevel: PaymentLevel) {
        substance = Member(name: name, memberType: .partyOrganizer, paymentLevel: paymentLevel)
    }
}



extension Organizer: CustomDebugStringConvertible {

    var debugDescription: String {
        debugString(subject: self, value: substance)
    }
}
