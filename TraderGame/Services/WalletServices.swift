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
            valueCrypto = sharedStorage.getStorageInCurrentDay(numberOfDay: numberOfDay)[number]
        }
        return valueCrypto
    }
    
    func getChangeCurrency(name: String, date: String) -> Double {
        var changeCurrency = 0.0
        let numberOfDay = sharedStorage.getNumberDayInCalendar(day: date)
        let array = getCurrencyForCryptoForDay(name: name, numberDate: numberOfDay)
        changeCurrency = (array[array.count - 1] - array[0]) / 100
        return changeCurrency
    }

//MARK: - Support private methods
    private func getCurrencyForCryptoForDay(name: String, numberDate: Int) -> [Double] {
        var currency = [Double]()
        for index in 0 ... numberDate {
            let array = sharedStorage.getStorageInCurrentDay(numberOfDay: index)
            var price = 0.0
            array.forEach { valueCrypto in
                if valueCrypto.name == name {
                    price = NSDecimalNumber(decimal: valueCrypto.price).doubleValue
                }
            }
            currency.append(price)
        }
        return currency
    }
    
}
