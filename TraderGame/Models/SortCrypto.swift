//
//  SortCrypto.swift
//  TraderGame
//
//  Created by Anton Nikolaev on 09.03.2022.
//

import Foundation

struct AllValuesRateForCurrentCrypto {
    let name: String
    let urlString: String
    var values: [ValueInCurrentDay]
}

struct ValueInCurrentDay {
    let date: Date
    let rate: String
    
    init(history: History) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let historyDate = dateFormatter.date(from: history.date ?? "")
        let historyRate = history.priceUsd ?? ""
        
        self.date = historyDate ?? Date()
        self.rate = historyRate
    }
}
