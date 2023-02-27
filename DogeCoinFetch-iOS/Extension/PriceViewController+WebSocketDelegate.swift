//
//  PriceViewController+WebSocketDelegate.swift
//  DogeCoinFetch-iOS
//
//  Created by BOONGKI KWAK on 2023/02/28.
//

import Foundation
import Starscream

extension PriceViewController: WebSocketDelegate {
    
    func didReceive(event: WebSocketEvent, client: WebSocketClient) {
        switch event {
        case .connected(let headers):
            isConnected = true
            requestPrice()
            print("websocket is connected: \(headers)")
        case .disconnected(let reason, let code):
            isConnected = false
            print("websocket is disconnected: \(reason) with code: \(code)")
        case .text(let string):
            print("Received text: \(string)")
            
            guard let json = string.data(using: .utf8) else { return }
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
            coinCollectionView.reloadData()
            
        case .binary(let data):
            print("Received data: \(data.count)")
        case .ping(_):
            break
        case .pong(_):
            break
        case .viabilityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled:
            isConnected = false
        case .error(let error):
            isConnected = false
            handleError(error)
        }
    }
    
    func handleError(_ error: Error?) {
        if let e = error as? WSError {
            print("websocket encountered an error: \(e.message)")
        } else if let e = error {
            print("websocket encountered an error: \(e.localizedDescription)")
        } else {
            print("websocket encountered an error")
        }
    }
}
