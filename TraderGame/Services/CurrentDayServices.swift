//
//  CurrentDayServices.swift
//  TraderGame
//
//  Created by Anton Nikolaev on 16.03.2022.
//

import Foundation
class CurrentDayServices {
    private let sharedStorage = Storage.shared
    
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
    
}
