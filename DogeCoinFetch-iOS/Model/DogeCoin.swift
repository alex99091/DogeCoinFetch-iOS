//
//  DogeCoin.swift
//  DogeCoinFetch-iOS
//
//  Created by BOONGKI KWAK on 2023/02/27.
//

import Foundation

struct DogeCoin: Codable {
    var type: String?
    var value: String?
    var exchangeName: String?
    var priceBase: String?
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case value = "value"
        case exchangeName = "exchange_name"
        case priceBase = "price_base"
    }
}
