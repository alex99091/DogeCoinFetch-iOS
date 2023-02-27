//
//  PriceViewController+WebSocketDelegate.swift
//  DogeCoinFetch-iOS
//
//  Created by BOONGKI KWAK on 2023/02/27.
//

import Foundation

extension PriceViewController: URLSessionWebSocketDelegate {
  func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
    print("open")
  }
    
  func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
    print("close")
  }
}

