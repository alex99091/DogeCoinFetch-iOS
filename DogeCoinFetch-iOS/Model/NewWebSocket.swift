//
//  NewWebSocket.swift
//  DogeCoinFetch-iOS
//
//  Created by BOONGKI KWAK on 2023/02/28.
//

import Foundation

class NewWebSocket: NSObject, URLSessionWebSocketDelegate {
    
    let urlString = "wss://ws.dogechain.info/inv"
    var websocketTask: URLSessionWebSocketTask?
    weak var delegate: NewWebSocketDelegate?
    
    func connect() {
        let session = URLSession(configuration: .default,
                                 delegate: self,
                                 delegateQueue: OperationQueue())
        
        guard let url = URL(string: urlString) else { return }
        websocketTask = session.webSocketTask(with: url)
        websocketTask?.resume()
        receive()
    }
    
    func receive() {
        websocketTask?.receive(completionHandler: { (result: Result<URLSessionWebSocketTask.Message, Error>) in
            switch result {
            case .success(.string(let string)):
                print("msg success(.string) - \(string)")
                self.delegate?.webSocketDidReceiveMessage(string)
            case .success(.data(let data)):
                print("msg .success(.data) - \(data)")
            case .success(let message):
                print("message .success()- \(message)")
            case .failure(let failure):
                print("failure - \(failure)")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                self.receive()
            })
        })
    }
    
    func send(message: String) {
        let message = URLSessionWebSocketTask.Message.string(message)
        websocketTask?.send(message) { error in
            if let error = error {
                print("Error sending message: \(error.localizedDescription)")
            } else {
                print("Message sent successfully")
            }
        }
    }
    
    func close() {
        websocketTask?.cancel(with: .goingAway, reason: nil)
    }
    
    // Delegate methods
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        delegate?.webSocketDidConnect()
    }
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        delegate?.webSocketDidDisconnect()
    }
}

protocol NewWebSocketDelegate: AnyObject {
    func webSocketDidConnect()
    func webSocketDidReceiveMessage(_ message: String)
    func webSocketDidDisconnect()
}
