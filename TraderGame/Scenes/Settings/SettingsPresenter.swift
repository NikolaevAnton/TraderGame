//
//  SettingsPresenter.swift
//  TraderGame
//
//  Created by Anton Nikolaev on 08.03.2022.
//

import Foundation

protocol SettingsViewProtocol: AnyObject {
    func presentCountValuesInCurrentDay(_ countValues: Int)
}

protocol SettingsPresenterProtocol {
    init(view: SettingsViewProtocol)
    func loadValuesInCurrentDay()
}

class SettingsPresenter: SettingsPresenterProtocol {
    unowned let view: SettingsViewProtocol
    
    required init(view: SettingsViewProtocol) {
        self.view = view
    }
    
    func loadValuesInCurrentDay() {
        NetworkManager.shared.fetchCrypto(dataType: AllAssetsDescription.self, from: Link.allAssets.rawValue) { [unowned self] result in
            switch result {
            case .success(let data):
                let dataCrypto = data.data ?? []
                view.presentCountValuesInCurrentDay(dataCrypto.count)
            case .failure(let error):
                print(error)
            }
        }
    }
}
