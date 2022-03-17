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

}

protocol MainPresenterProtocol {
    init(view: MainViewProtocol)
    func loadValuesInCurrentDay()
    func loadStringValuesCrypto()

}

class MainPresenter: MainPresenterProtocol {

    private var day = 0
    unowned let view: MainViewProtocol
    private let currentDayServices = CurrentDayServices()
    
    required init(view: MainViewProtocol) {
        self.view = view
    }
    
    func loadValuesInCurrentDay() {
        view.presentCountValuesInCurrentDay(
            countValuesYourCrypto: currentDayServices.getCountYourMoney(),
            countValuesInternetCrypto: currentDayServices.getCountCryptoValuesInCurrentDay(day: day)
        )
    }
    
    func loadStringValuesCrypto() {
        view.presentStringsValuesCrypto(
            valuesYouMoney: currentDayServices.getStringValuesInArrayYouMoney(),
            valuesCrypto: currentDayServices.getStringValuesInArrayCryptoData(in: day))
    }
    
    
}
