//
//  OtherWebSocket.swift
//  DogeCoinFetch-iOS
//
//  Created by BOONGKI KWAK on 2023/02/28.
//

import Foundation

// 웹 소켓 직접 구현하기
enum OtherWebSocketError: Error {
    case invalidURL
}

enum OtherWebSocketEvent {
    case connected([String: String])
    case disconnected(String, UInt16)
    case text(String)
    case error(Error?)
}

protocol OtherWebSocketClient: AnyObject {
    func connect()
    func disconnect(closeCode: UInt16)
    func write(string: String, completion: (() -> ())?)
    func write(data: Data, completion: (() -> ())?)
}

class OtherWebSocket: NSObject, URLSessionDelegate {
    
    static let shared = OtherWebSocket()
    weak var delegate: URLSessionWebSocketDelegate?
    var webSocketTask: URLSessionWebSocketTask?
    var onEvent: ((OtherWebSocketEvent) -> Void)?
    var isConnected = false
    
    func openWebSocket() throws {
        let urlString = "wss://ws.dogechain.info/inv"
        guard let url = URL(string: urlString) else { throw OtherWebSocketError.invalidURL }
        
        let urlSession = URLSession(
          configuration: .default,
          delegate: self,
          delegateQueue: OperationQueue()
        )
        let webSocketTask = urlSession.webSocketTask(with: url)
        webSocketTask.resume()
    }
    
    func closeWebSocket() {
      self.webSocketTask = nil
      self.delegate = nil
    }
    
    private func send(message: String?, data: Data?) {
      let taskMessage: URLSessionWebSocketTask.Message
      if let string = message {
        taskMessage = URLSessionWebSocketTask.Message.string(string)
      } else if let data = data {
        taskMessage = URLSessionWebSocketTask.Message.data(data)
      } else {
        return
      }
      self.webSocketTask?.send(taskMessage, completionHandler: { error in
        guard let error = error else { return }
      })
    }
    
    func send(message: String) {
      self.send(message: message, data: nil)
    }
    
    func receive(event: OtherWebSocketEvent, client: OtherWebSocketClient) {
        switch event {
        case .connected(let headers):
            isConnected = true
            print("websocket is connected: \(headers)")
        case .disconnected(let reason, let code):
            isConnected = false
            print("websocket is disconnected: \(reason) with code: \(code)")
        case .text(let string):
            print("Received text: \(string)")
            
            guard let json = string.data(using: .utf8) else { return }
            let decoder = JSONDecoder()
            
            guard let dataResponse = try? decoder.decode(DataResponse.self, from: json) else { return }
//            guard let dogeCoinCurrency = dataResponse.x.priceBase else { return }
//            switch dogeCoinCurrency {
//            case "USD": dogeCoinPrice.updateValue(dataResponse.x.value!, forKey: "USD")
//                dogeCoinPrice.updateValue(String(Double(dataResponse.x.value!)! * USDtoKRWCurrency), forKey: "KRW")
//            case "ETH": dogeCoinPrice.updateValue(dataResponse.x.value!, forKey: "ETH")
//            case "BTC": dogeCoinPrice.updateValue(dataResponse.x.value!, forKey: "BTC")
//            default: print("none")
//            }
        case .error(let error):
            isConnected = false
            print("error: \(String(describing: error))")
        }
    }
}
