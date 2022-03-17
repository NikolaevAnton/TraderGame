//
//  Storage.swift
//  TraderGame
//
//  Created by Anton Nikolaev on 13.03.2022.
//

import Foundation

class Storage {
    static let shared = Storage()
    private let downloadData: DownloadData!
    private var arrayValuesInCurrentDayOneYearHistory: [StorageValuesForEachDay] = []
    private var arrayYourCrypto: [ValueCrypto] = []
    private var calendar: [Date] = []
    
    private init() {
        downloadData = DownloadData.shared.self
        createCalendar()
        createYourMoney()
        createValuesInCurrentDay()
        getCryptoPriceInArrayAllValues()
        seachMinimumCryptoArray()
    }
    
//MARK: - getter result analiz array AllValuesRateForCurrentCrypto
    func getCountValuesCrypto() -> Int {
        guard let array = arrayValuesInCurrentDayOneYearHistory.first else { return 0}
        return array.values.count
    }
    
    func getStorageInCurrentDay(numberOfDay: Int) -> [ValueCrypto] {
        let check = 0..<364
        var array = [ValueCrypto]()
        if !check.contains(numberOfDay) {
            print("wrong number of date")
            array = arrayValuesInCurrentDayOneYearHistory[0].values
        }
        array = arrayValuesInCurrentDayOneYearHistory[numberOfDay].values
        return array
    }
    
    func getYourMoneyInCurrentDay() -> [ValueCrypto] {
        arrayYourCrypto
    }
    
    func getDayInCalendar(day: Int) -> Date {
        let check = 0..<364
        var seachDate = Date()
        if !check.contains(day) {
            print("wrong number of date")
        } else {
            seachDate = calendar[day]
        }
        return seachDate
    }
    
//MARK: - create your money
        private func createYourMoney() {
            var price = Decimal()
            var count = Decimal()
            do {
                price = try Decimal("1", format: .number)
                count = try Decimal("10000", format: .number)
            } catch {
                price = Decimal()
                count = Decimal()
            }
            let dollars = ValueCrypto(name: "Dollar", price: price, count: count)
            arrayYourCrypto.append(dollars)
        }
//MARK: - private func create array values crypto in current day in one year history

    private func createCalendar() {
        var days = Set<Date>()
        for allValues in downloadData.getAllValues() {
            allValues.values.forEach { valueInCurrentDay in
                days.update(with: valueInCurrentDay.date)
            }
        }
        calendar = days.sorted(by: { min, max in
            min < max
        })
    }
    
    private func createValuesInCurrentDay() {
        calendar.forEach { day in
            arrayValuesInCurrentDayOneYearHistory.append(StorageValuesForEachDay(date: day, values: []))
        }
    }
    
    private func getCryptoPriceInArrayAllValues() {
        downloadData.getAllValues().forEach { allValues in
            let name = allValues.name
            allValues.values.forEach { valueInCurrentDay in
                var price = Decimal()
                do {
                    price = try Decimal(valueInCurrentDay.rate, format: .number)
                } catch {
                    price = Decimal()
                }
                let valueCrypto = ValueCrypto(name: name, price: price, count: nil)
                let date = valueInCurrentDay.date
                updateValuesInCurrentDay(value: valueCrypto, date: date)
            }
        }
    }
    
    private func updateValuesInCurrentDay(value: ValueCrypto, date: Date) {
        guard let index = calendar.firstIndex(of: date) else { return }
        let valuesInCurrentDay = arrayValuesInCurrentDayOneYearHistory[index].values
        if !isContaintsValueInCurrentDay(values: valuesInCurrentDay, seachValue: value) {
            arrayValuesInCurrentDayOneYearHistory[index].values.append(value)
        }
    }
    
    private func isContaintsValueInCurrentDay(values: [ValueCrypto], seachValue: ValueCrypto) -> Bool {
        if values.isEmpty {
            return false
        }
        for valueCrypto in values {
            if valueCrypto.name == seachValue.name {
                return true
            }
        }
        return false
    }
    
//due to loading errors, the array of values ​​may be different
//therefore, it is necessary to find such an array of cryptocurrencies that will be every day

    private func seachMinimumCryptoArray() {
        var tempValues = transcryptValuesCryptoToString(thisDayArray: arrayValuesInCurrentDayOneYearHistory[0].values)
        
        for index in 1..<calendar.count {
            let nextDayValues = transcryptValuesCryptoToString(thisDayArray: arrayValuesInCurrentDayOneYearHistory[index].values)
            let arrayWithMinimumValues = compareArrays(array1: tempValues, array2: nextDayValues)
            tempValues = arrayWithMinimumValues
        }
        
        changeArrayValuesInCurrentDayOneYearHistory(arrayNames: tempValues)
        /*
        arrayValuesInCurrentDayOneYearHistory.forEach { storageValuesForEachDay in
            print("day: \(storageValuesForEachDay.date) array values count: \(storageValuesForEachDay.values.count)")
        }
         */
    }
    
    private func transcryptValuesCryptoToString(thisDayArray: [ValueCrypto]) -> [String] {
        var arrayString = [String]()
        thisDayArray.forEach { valueCrypto in
            arrayString.append(valueCrypto.name)
        }
        return arrayString
    }
    
    private func compareArrays(array1: [String], array2: [String]) -> [String] {
        var compared = [String]()
        
        if array1.count < array2.count {
            array1.forEach { element in
                if array2.contains(element) {
                    compared.append(element)
                }
            }
        } else {
            array2.forEach { element in
                if array1.contains(element) {
                    compared.append(element)
                }
            }
        }
        
        return compared
    }
    
    private func changeArrayValuesInCurrentDayOneYearHistory(arrayNames: [String]) {
        for index in 0 ..< arrayValuesInCurrentDayOneYearHistory.count {
            let currentDayValues = arrayValuesInCurrentDayOneYearHistory[index].values
            arrayValuesInCurrentDayOneYearHistory[index].values = returnMinimumValueCryptoArray(valuesCrypto: currentDayValues, arrayNames: arrayNames)
        }
    }
    
    private func returnMinimumValueCryptoArray(valuesCrypto: [ValueCrypto], arrayNames: [String]) -> [ValueCrypto] {
        var minimumValueCrypto = [ValueCrypto]()
        valuesCrypto.forEach { valueCrypto in
            if arrayNames.contains(valueCrypto.name) {
                minimumValueCrypto.append(valueCrypto)
            }
        }
        return minimumValueCrypto
    }
    
    

}
