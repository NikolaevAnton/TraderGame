//
//  SettingsPresenter.swift
//  TraderGame
//
//  Created by Anton Nikolaev on 08.03.2022.
//

import Foundation

protocol SettingsViewProtocol: AnyObject {
    func presentCountValuesInCurrentDay(_ countValues: Int)
    func presentCountValuesInOneYearHistory(_ countValues: Int)
    func presentResultForSortValues(_ countValues: Int)
}

protocol SettingsPresenterProtocol {
    init(view: SettingsViewProtocol)
    func loadValuesInCurrentDay()
    func loadValuesInOneYearHistory()
    func sortValuesInOneYearHistory()
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
    func loadValuesInOneYearHistory() {
        DownloadData.shared.downloadValuesInOneYearHistory { [unowned self] in
            view.presentCountValuesInOneYearHistory(DownloadData.shared.getCountAllValuesOnYearHistory())
            //DownloadData.shared.testDescriptionForCheckDownloadValues()
        }
    }
    
    func sortValuesInOneYearHistory() {
        Storage.shared.getCountValuesCrypto {[unowned self] count in
            view.presentResultForSortValues(count)
        }
    }
}
