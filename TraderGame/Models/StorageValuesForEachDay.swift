//
//  StorageValuesForEachDay.swift
//  TraderGame
//
//  Created by Anton Nikolaev on 13.03.2022.
//

import Foundation

struct StorageValuesForEachDay {
    let date: Date
    let values: [ValueCrypto]
}

struct ValueCrypto {
    let name: String
    let price: Decimal
    let count: Decimal?
}
