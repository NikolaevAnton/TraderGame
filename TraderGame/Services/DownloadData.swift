//
//  DownloadData.swift
//  TraderGame
//
//  Created by Anton Nikolaev on 09.03.2022.
//

import Foundation

class DownloadData {
    
    static let shared = DownloadData()
    private init() {}
    
//MARK: - Private propirties for keep data
    private var cryptoArrays = [Crypto]()
    private var cryptoArrayOneYearHistory = [AllValuesRateForCurrentCrypto]()

//MARK: - Work methods for get values to website and save
    func downloadValuesInCurrentDay(completion: @escaping() -> Void) {
        NetworkManager.shared.fetchCrypto(dataType: AllAssetsDescription.self, from: Link.allAssets.rawValue) { [unowned self] result in
            switch result {
            case .success(let data):
                cryptoArrays = data.data ?? []
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func downloadValuesInOneYearHistory(completion: @escaping() -> Void) {
        creatArrayValuesCryptoInOneYearHistory()
        for (index, _) in cryptoArrayOneYearHistory.enumerated() {
            let link = cryptoArrayOneYearHistory[index].urlString
            downloadHistory(link: link) { valuesInCurrentDay in
                self.cryptoArrayOneYearHistory[index].values = valuesInCurrentDay
                if index == self.cryptoArrayOneYearHistory.count - 1 {
                    completion()
                }
            }
        }
    }
    
//MARK: - Getter methods for present values
    func getCountCrypto() -> Int {
        cryptoArrays.count
    }
    
    func getCountAllValuesOnYearHistory() -> Int {
        var count = 0
        cryptoArrayOneYearHistory.forEach { allValues in
            count += allValues.values.count
        }
        return count
    }
    
    func getAllValues() -> [AllValuesRateForCurrentCrypto] {
        cryptoArrayOneYearHistory
    }
    
//MARK: - Test methods
    /*
    func testDescriptionForCheckDownloadValues() {
        guard let cryptoHistory = cryptoArrayOneYearHistory.last else { return }
        print("Name: \(cryptoHistory.name) Link: \(cryptoHistory.urlString)")
        cryptoHistory.values.forEach { value in
            print("Rate: \(value.rate) Date: \(value.date)")
        }
    }
    */
//MARK: - Support private methods
    private func creatArrayValuesCryptoInOneYearHistory() {
        cryptoArrays.forEach { crypto in
            let name = crypto.name ?? ""
            let id = crypto.id ?? ""
            let urlString = Link.allAssets.rawValue + id + Link.history.rawValue
            let allValuesRateForCurrentCrypto = AllValuesRateForCurrentCrypto(name: name, urlString: urlString, values: [])
            self.cryptoArrayOneYearHistory.append(allValuesRateForCurrentCrypto)
        }
    }
    
    private func downloadHistory(link: String, completion: @escaping([ValueInCurrentDay]) -> Void) {
        NetworkManager.shared.fetchCrypto(dataType: AllHistoryDesription.self, from: link) { result in
            switch result {
            case .success(let data):
                let historyArrays = data.data ?? []
                var valueInCurrentDatArray = [ValueInCurrentDay]()
                historyArrays.forEach { history in
                    valueInCurrentDatArray.append(ValueInCurrentDay(history: history))
                }
                completion(valueInCurrentDatArray)
            case .failure(let error):
                print(error)
            }
        }
    }
}
