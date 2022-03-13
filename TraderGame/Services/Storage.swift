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
    private var calendar: [Date] = []
    private var namesCrypto: [String] = []
    
    private init() {
        downloadData = DownloadData.shared.self
        createCalendar()
        print("min calendar: \(String(describing: calendar.first))")
        print("max calendar: \(String(describing: calendar.last))")
        createValuesInCurrentDay()
        getCryptoPriceInArrayAllValues()
        createNames()

    }
    
//MARK: - getter result analiz array AllValuesRateForCurrentCrypto
    func getArrayValues() -> [StorageValuesForEachDay] {
        arrayValuesInCurrentDayOneYearHistory
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
    
    private func createNames() {
        var namesInThisDay = [String]()
        var namesInFirstDay = [String]()
        let thisDayValues = arrayValuesInCurrentDayOneYearHistory[calendar.endIndex - 1]
        let firstDayValuse = arrayValuesInCurrentDayOneYearHistory[0]
        thisDayValues.values.forEach { valueCrypto in
            namesInThisDay.append(valueCrypto.name)
        }
        firstDayValuse.values.forEach { valueCrypto in
            namesInFirstDay.append(valueCrypto.name)
        }
        print("in \(calendar.endIndex) crypto names: \(namesInThisDay.count)")
        print("in \(calendar[0]) crypto names: \(namesInFirstDay.count)")
        
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

}
