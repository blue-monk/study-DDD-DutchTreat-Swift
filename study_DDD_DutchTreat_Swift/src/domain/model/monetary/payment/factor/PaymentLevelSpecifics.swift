//
//  PaymentLevelSpecifics.swift
//  study_DDD_DutchTreat_Swift
//
//  Created by blue-monk on 2020/01/26.
//  Copyright © 2020 blue-monk. All rights reserved.
//

import Foundation

struct PaymentLevelSpecifics {

    private var weightsByLevel: [PaymentLevel : Weight] = [:]
}

//MARK: 初期化
extension PaymentLevelSpecifics {

    init(moreWeight: Weight, standardWeight: Weight, lessWeight: Weight) {

        weightsByLevel[.more] = moreWeight
        weightsByLevel[.standard] = standardWeight
        weightsByLevel[.less] = lessWeight

        _validate()
    }

    private func _validate() {

        let more = weightsByLevel[.more]!;
        let standard = weightsByLevel[.standard]!;
        let less = weightsByLevel[.less]!;

        assert(more >= standard, "more, standard, less の割合の大小関係が不正です. [more=\(more), standard=\(standard), less=\(less)]")
        assert(standard >= less, "more, standard, less の割合の大小関係が不正です. [more=\(more), standard=\(standard), less=\(less)]");
    }
}

//MARK: Weight 取得
extension PaymentLevelSpecifics {

    func weight(for paymentLevelHolder: PaymentLevelHolder) -> Weight {
        return weightsByLevel[paymentLevelHolder.paymentLevel]!;
    }
}



extension PaymentLevelSpecifics: CustomDebugStringConvertible {

    var debugDescription: String {
        "\(weightsByLevel)"
    }
}
