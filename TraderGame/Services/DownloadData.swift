//
//  DownloadData.swift
//  TraderGame
//
//  Created by Anton Nikolaev on 09.03.2022.
//

import Foundation

class DownloadData {
    
    static let shared = DownloadData()
    
    private var cryptoArrays = [Crypto]()
    
    private init() {}
    
    func downloadValuesInCurrentDay(completion: @escaping()->Void) {
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
    
    func getCountCrypto() -> Int {
        cryptoArrays.count
    }
}
