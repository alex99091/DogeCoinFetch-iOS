//
//  PriceViewModel.swift
//  DogeCoinFetch-iOS
//
//  Created by BOONGKI KWAK on 2023/02/28.
//

import SwiftUI

class PriceViewModel: ObservableObject {
    
    @Published var dogeCoinPrice: [String: String] = ["KRW": "105.05","ETH": "0.00005050","USD": "0.08120","BTC": "0.00000350"]
    var newWebSocket = NewWebSocket()
    let USDtoKRWCurrency: Double = 1318.60
    let message = "{\"op\":\"price_sub\"}"
    
    init() {
        newWebSocket.connect()
        newWebSocket.delegate = self
        newWebSocket.send(message: message)
    }
    
}

extension PriceViewModel: NewWebSocketDelegate {
    func webSocketDidReceiveMessage(_ message: String) {
        print("Received message: \(message)")
        guard let json = message.data(using: .utf8) else { return }
        let decoder = JSONDecoder()
        
        guard let dataResponse = try? decoder.decode(DataResponse.self, from: json) else { return }
        guard let dogeCoinCurrency = dataResponse.x.priceBase else { return }
        switch dogeCoinCurrency {
        case "USD": dogeCoinPrice.updateValue(dataResponse.x.value!, forKey: "USD")
            dogeCoinPrice.updateValue(String(Double(dataResponse.x.value!)! * USDtoKRWCurrency), forKey: "KRW")
        case "ETH": dogeCoinPrice.updateValue(dataResponse.x.value!, forKey: "ETH")
        case "BTC": dogeCoinPrice.updateValue(dataResponse.x.value!, forKey: "BTC")
        default: print("none")
        }
        print(dogeCoinPrice)
    }
    func webSocketDidConnect() {}
    func webSocketDidDisconnect() {}
}
