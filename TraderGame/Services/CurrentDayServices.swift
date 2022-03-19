//
//  CurrentDayServices.swift
//  TraderGame
//
//  Created by Anton Nikolaev on 16.03.2022.
//

import Foundation
class CurrentDayServices {
    private let sharedStorage = Storage.shared
    private let diapason: [Int]!

    init() {
        diapason = Array(0..<sharedStorage.getCountCalendar())
    }

//MARK: - Getters
    func getCountCryptoValuesInCurrentDay(day: Int) -> Int {
        sharedStorage.getStorageInCurrentDay(numberOfDay: day).count
    }
    
    func getCountYourMoney() -> Int {
        sharedStorage.getYourMoneyInCurrentDay().count
    }
    
    func getStringValuesInArrayYouMoney() -> [String] {
        let value = sharedStorage.getYourMoneyInCurrentDay()
        var stringYourMoneys = [String]()
        value.forEach { valueCrypto in
            let moneyString = valueCrypto.name + " course: \(valueCrypto.price)" + " count: \(String(describing: valueCrypto.count ?? 0))"
            stringYourMoneys.append(moneyString)
        }
        return stringYourMoneys
    }
    
    func getStringValuesInArrayCryptoData(in day: Int) -> [String] {
        let value = sharedStorage.getStorageInCurrentDay(numberOfDay: day)
        var stringsCrypto = [String]()
        value.forEach { valueCrypto in
            let cryptoString = valueCrypto.name + " course: \(valueCrypto.price)"
            stringsCrypto.append(cryptoString)
        }
        return stringsCrypto
    }
    
    func getStringValueDate(in day: Int) -> String {
        let date = sharedStorage.getDayInCalendar(day: day)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY, MMM d"
        return dateFormatter.string(from: date)
    }
    
    
//MARK: - Sorting Values
    func ascendingOrder() {
        diapason.forEach { day in
            let valuesInCurrentDay = sharedStorage.getStorageInCurrentDay(numberOfDay: day)
            sharedStorage.setChangeResult(values: getAscendingArray(values: valuesInCurrentDay), day: day)
        }
    }
    
    func descendingValues() {
        diapason.forEach { day in
            let valuesInCurrentDay = sharedStorage.getStorageInCurrentDay(numberOfDay: day)
            sharedStorage.setChangeResult(
                values: getDescendingValues(values: valuesInCurrentDay), day: day)
        }
    }
    
    func withoutOrder() {
        diapason.forEach { day in
            let valuesInCurrentDay = sharedStorage.getStorageInCurrentDay(numberOfDay: day)
            sharedStorage.setChangeResult(
                values: getWithoutOrder(values: valuesInCurrentDay), day: day)
        }
    }
    
//MARK: - Support private methods for sorting values
    private func getAscendingArray(values: [ValueCrypto]) -> [ValueCrypto] {
        values.sorted { valueCryptoOne, valueCryptoSecond in
            valueCryptoSecond.price.isLess(than: valueCryptoOne.price)
        }
    }
    
    private func getDescendingValues(values: [ValueCrypto]) -> [ValueCrypto] {
        values.sorted { valueCryptoOne, valueCryptoSecond in
            valueCryptoOne.price.isLess(than: valueCryptoSecond.price)
        }
    }
    
    private func getWithoutOrder(values: [ValueCrypto]) -> [ValueCrypto] {
        values.shuffled()
    }
    
}
