//
//  WalletServices.swift
//  TraderGame
//
//  Created by Anton Nikolaev on 19.03.2022.
//

import Foundation

class WalletServices {
    
    private let sharedStorage: Storage!
    
    init() {
        sharedStorage = Storage.shared
    }
    
    func getValueCrypto(itIsYourMoney: Bool, number: Int, date: String) -> ValueCrypto {
        let numberOfDay = sharedStorage.getNumberDayInCalendar(day: date)
        let valueCrypto: ValueCrypto
        if itIsYourMoney {
            valueCrypto = sharedStorage.getYourMoneyInCurrentDay()[number]
        } else {
            print("wallet service. day: \(date)")
            valueCrypto = sharedStorage.getStorageInCurrentDay(numberOfDay: numberOfDay)[number]
            print("value: \(valueCrypto.price)")
        }
        return valueCrypto
    }
}
