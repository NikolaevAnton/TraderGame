//
//  SettingsPresenter.swift
//  TraderGame
//
//  Created by Anton Nikolaev on 08.03.2022.
//

import Foundation

protocol SettingsViewProtocol: AnyObject {
    func presentCountValuesInCurrentDay(_ countValues: Int)
    func getFirstElementInCryptoArrray(discription: String)
}

protocol SettingsPresenterProtocol {
    init(view: SettingsViewProtocol)
    func loadValuesInCurrentDay()
    func getValueInArray()
}

class SettingsPresenter: SettingsPresenterProtocol {
    
    unowned let view: SettingsViewProtocol
    
    required init(view: SettingsViewProtocol) {
        self.view = view
    }
    
    func loadValuesInCurrentDay() {
        DownloadData.shared.downloadValuesInCurrentDay() {[unowned self] in
            view.presentCountValuesInCurrentDay(DownloadData.shared.getCountCrypto())
        }
    }
    func getValueInArray() {
        view.getFirstElementInCryptoArrray(discription: DownloadData.shared.getFirstValue())
    }
}
