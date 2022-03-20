//
//  DetailPresenter.swift
//  TraderGame
//
//  Created by Anton Nikolaev on 19.03.2022.
//

import Foundation
protocol DetailViewProtocol: AnyObject {
    func presentCrypto(name: String, price: String, count: String?)
    func presentWallet(name: String, price: String, count: String)
    func presentChangeCourse(change: Double)
    func presentMaxCountForBuy(maxCount: String)
}

protocol DetailPresenterProtocol {
    init(view: DetailViewProtocol)
    func setIndexPath(index: IndexPath)
    func setDate(day: String)
    func getCryptoValue()
    func getChangeHistory()
    func setMaxCountForBuy()
    func setCountValueForBuy(value: Double)
}

class DetailPresenter: DetailPresenterProtocol {
    
    unowned let view: DetailViewProtocol
    private var isItYourWallet = true
    private var numberInArray = 0
    private var dayDate = ""
    private let wallet = WalletServices()
    private var crypto: ValueCrypto?
    private var maxCount = 0.0
    
    required init(view: DetailViewProtocol) {
        self.view = view
    }
    
    func setIndexPath(index: IndexPath) {
        if index.section == 0 {
            isItYourWallet = true
        } else {
            isItYourWallet = false
        }
        numberInArray = index.row
    }
    
    func setDate(day: String) {
       dayDate = day
    }
    
    func getCryptoValue() {
        crypto = wallet.getValueCrypto(itIsYourMoney: isItYourWallet, number: numberInArray, date: dayDate)
        guard let crypto = crypto else { return }
        let price = "\(crypto.price)"
        var count: String?
        if crypto.count == nil {
            count = nil
        } else {
            count = "\(crypto.count ?? Decimal())"
        }
        view.presentCrypto(name: crypto.name, price: price, count: count)
        let moneyInWallet = wallet.getValueCrypto(itIsYourMoney: true, number: 0, date: dayDate)
        let priceWallet = "\(moneyInWallet.price)"
        guard let countWallet = moneyInWallet.count else { return }
        view.presentWallet(name: moneyInWallet.name, price: priceWallet, count: "\(countWallet)")
    }
    
    func getChangeHistory() {
        view.presentChangeCourse(change: wallet.getChangeCurrency(name: crypto?.name ?? "", date: dayDate))
    }
    
    func setMaxCountForBuy() {
        guard let crypto = crypto else { return }
        let moneyInWallet = wallet.getValueCrypto(itIsYourMoney: true, number: 0, date: dayDate)
        let maxCount = (moneyInWallet.count ?? Decimal()) / crypto.price
        view.presentMaxCountForBuy(maxCount: "\(NSDecimalNumber(decimal: maxCount).doubleValue)")
    }
    
    func setCountValueForBuy(value: Double) {
        guard let crypto = crypto else { return }
        wallet.changeYouWalletForBuyCurrency(crypto: crypto, count: value)
    }
}

