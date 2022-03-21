//
//  MainPresenter.swift
//  TraderGame
//
//  Created by Anton Nikolaev on 16.03.2022.
//

import Foundation
protocol MainViewProtocol: AnyObject {
    func presentCountValuesInCurrentDay(countValuesYourCrypto: Int, countValuesInternetCrypto: Int)
    func presentStringsValuesCrypto(valuesYouMoney: [String], valuesCrypto: [String])
    func presenterLoadStringValueForDate(value: String)
    func presentSort(sort: String)
}

protocol MainPresenterProtocol {
    init(view: MainViewProtocol)
    func loadCountValuesInCurrentDay()
    func loadStringValuesCrypto()
    func loadStringValueDate()
    func changeDay()
    func sortValues()

}

enum KindOfSorting: String {
    case inAscendingOrder
    case descendingValues
    case withoutOrder
}

class MainPresenter: MainPresenterProtocol {

    private var kindOfSorting: KindOfSorting = .withoutOrder
    private var day = 0
    unowned let view: MainViewProtocol
    private let currentDayServices = CurrentDayServices()
    
    required init(view: MainViewProtocol) {
        self.view = view
    }
    
    func loadCountValuesInCurrentDay() {
        delateZeroValues()
        view.presentCountValuesInCurrentDay(
            countValuesYourCrypto: currentDayServices.getCountYourMoney(),
            countValuesInternetCrypto: currentDayServices.getCountCryptoValuesInCurrentDay(day: day)
        )
    }
    
    func loadStringValuesCrypto() {
        delateZeroValues()
        view.presentStringsValuesCrypto(
            valuesYouMoney: currentDayServices.getStringValuesInArrayYouMoney(),
            valuesCrypto: currentDayServices.getStringValuesInArrayCryptoData(in: day))
    }
    
    func loadStringValueDate() {
        view.presenterLoadStringValueForDate(value: currentDayServices.getStringValueDate(in: day))
    }
    
    func changePriceInYouWallet() {
        currentDayServices.changePrice(in: day)
        loadCountValuesInCurrentDay()
        loadStringValuesCrypto()
    }
    
    func changeDay() {
        day += 1
        loadStringValuesCrypto()
        loadStringValueDate()
        changePriceInYouWallet()
    }
    
    func sortValues() {
        switch kindOfSorting {
        case .inAscendingOrder:
            kindOfSorting = .descendingValues
        case .descendingValues:
            kindOfSorting = .withoutOrder
        case .withoutOrder:
            kindOfSorting = .inAscendingOrder
        }
        print(kindOfSorting.rawValue)
        changeKindOfSorting()
        loadStringValuesCrypto()
        view.presentSort(sort: kindOfSorting.rawValue)
    }
    
    private func changeKindOfSorting() {
        
        switch kindOfSorting {
        case .inAscendingOrder:
            currentDayServices.ascendingOrder()
        case .descendingValues:
            currentDayServices.descendingValues()
        case .withoutOrder:
            currentDayServices.withoutOrder()
        }
    }
    
    private func delateZeroValues(){
        currentDayServices.delateZerroCountValuesInYourWallet()
    }
}
