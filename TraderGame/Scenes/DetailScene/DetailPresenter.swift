//
//  DetailPresenter.swift
//  TraderGame
//
//  Created by Anton Nikolaev on 19.03.2022.
//

import Foundation
protocol DetailViewProtocol: AnyObject {
    func presentCrypto(name: String, price: String, count: String?)
}

protocol DetailPresenterProtocol {
    init(view: DetailViewProtocol)
    func setIndexPath(index: IndexPath)
    func setDate(day: String)
    func getCryptoValue()
}

class DetailPresenter: DetailPresenterProtocol {

    unowned let view: DetailViewProtocol
    private var isItYourWallet = true
    private var numberInArray = 0
    private var dayDate = ""
    private let wallet = WalletServices()
    private var crypto: ValueCrypto?
    
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
    }
}

