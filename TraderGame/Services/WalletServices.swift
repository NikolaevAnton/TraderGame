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
    
    func getCountCurrentCurrency(name: String) -> Double {
        guard let count = sharedStorage.getCountCryptoInYourWallet(nameCrypto: name) else { return 0.0}
        return NSDecimalNumber(decimal: count).doubleValue
    }

//MARK: - New value in wallet for buy and sell action
    func changeYouWalletForBuyCurrency(crypto: ValueCrypto, count: Double) {
        let countDecimal = Decimal(count)
        let newCrypto = ValueCrypto(name: crypto.name, price: crypto.price, count: countDecimal)
        guard var dollarsCount = sharedStorage.getCountDollars() else { return }
        dollarsCount = dollarsCount - countDecimal * crypto.price
        if dollarsCount <= 0 {
            return
        }
        guard let _ = sharedStorage.getYourMoneyInCurrentDay(name: crypto.name) else {
            sharedStorage.changeDollarsCount(newCount: dollarsCount)
            sharedStorage.uppendNewValueInYouMoneyForBuy(value: newCrypto)
            return
        }
        sharedStorage.changeDollarsCount(newCount: dollarsCount)
        sharedStorage.changeValueInYourMoneyForBuy(value: newCrypto)
    }
    
    func changeYouWalletForSellCurrency(crypto: ValueCrypto, count: Double) {
        guard var cryptoCount = sharedStorage.getCountCryptoInYourWallet(nameCrypto: crypto.name) else { return }
        print("WALLET SERVICES. current count crypto: \(cryptoCount)")
        cryptoCount = cryptoCount - Decimal(count)
        if cryptoCount < 0 {
            return
        }
        guard var newCountDollars = sharedStorage.getCountDollars() else { return }
        newCountDollars += Decimal(count) * crypto.price
        print("WALLET SERVICES. new dollars count: \(newCountDollars)")
        /*
        if cryptoCount == 0 {
            sharedStorage.changeDollarsCount(newCount: newCountDollars)
            sharedStorage.delateCrypto(name: crypto.name)
            return
        }
         */
        sharedStorage.changeDollarsCount(newCount: newCountDollars)
        sharedStorage.changeValueInYourMoneyForSell(name: crypto.name, count: Decimal(count))
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
