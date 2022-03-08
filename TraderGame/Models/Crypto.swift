//
//  Crypto.swift
//  TraderGame
//
//  Created by Anton Nikolaev on 08.03.2022.
//

import Foundation

struct AllAssetsDescription: Decodable {
    let data: [Crypto]?
    let timestamp: Int?
}

struct Crypto: Decodable {
    let id: String?
    let rank: String?
    let symbol: String?
    let name: String?
    let supply: String?
    let maxSupply: String?
    let marketCapUsd: String?
    let volumeUsd24Hr: String?
    let priceUsd: String?
    let changePercent24Hr: String?
    let vwap24Hr: String?
    let explorer: String?
}

struct AllHistoryDesription: Decodable {
    let data: [History]?
    let timestamp: Int?
}

struct History: Decodable {
    let priceUsd: String?
    let time: Int?
    let date: String?
}
