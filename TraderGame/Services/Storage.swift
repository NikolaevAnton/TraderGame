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
    private var valuesInCurrentDay: [StorageValuesForEachDay] = []
    private var calendar: [Date] = []
    
    private init() {
        downloadData = DownloadData.shared.self
        createCalendar()
        print("min calendar: \(String(describing: calendar.first))")
        print("max calendar: \(String(describing: calendar.last))")
        createValuesInCurrentDay()
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
                print("name: \(valueCrypto.name) price: \(valueCrypto.price) date: \(date)")
            }
        }
    }
}
