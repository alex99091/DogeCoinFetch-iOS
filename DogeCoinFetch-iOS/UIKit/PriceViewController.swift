//
//  PriceViewController.swift
//  DogeCoinFetch-iOS
//
//  Created by BOONGKI KWAK on 2023/02/27.
//

import UIKit
import SwiftUI
import Starscream

class PriceViewController: UIViewController {
    
    // IB Outlet
    @IBOutlet weak var coinCollectionView: UICollectionView!
    @IBOutlet var currencyOutletCollection: [UIButton]!
    
    // Property
    var socket: WebSocket!
    var isConnected = false
    let server = WebSocketServer()
    let USDtoKRWCurrency: Double = 1318.60
    var dogeCoinPrice: [String: String] = ["KRW": "105.05","ETH": "0.00005050","USD": "0.08120","BTC": "0.00000350"]
    let yesterdayDogeCoinPrice: [String: String] = ["KRW": "109.10","ETH": "0.00005120","USD": "0.083","BTC": "0.00000362"]
    var currencyButtonStatus = false
    
    // Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.coinCollectionView.register(CoinCell.uinib, forCellWithReuseIdentifier: CoinCell.reuseIdentifier)
        self.coinCollectionView.dataSource = self
        self.coinCollectionView.delegate = self
        openWebSocket()
        currencyOutletCollection.forEach{ $0.addTarget(self, action: #selector(currencyButtonOutletCollectionTapped(_:)), for: .touchUpInside)}
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // Method
    func openWebSocket() {
        let urlString = "wss://ws.dogechain.info/inv"
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        socket.delegate = self
        socket.connect()
    }
    
    func requestPrice() {
        let message = "{\"op\":\"price_sub\"}"
        socket.write(string: message)
        print(socket.write(string: message))
    }
    
    // IB Action
    @objc func currencyButtonOutletCollectionTapped(_ sender: UIButton) {
        currencyOutletCollection.forEach{ $0.isSelected = $0.isTouchInside ? true : false}
        coinCollectionView.reloadData()
    }
}



extension PriceViewController {
    private struct VCRepresentable: UIViewControllerRepresentable {
        let priceViewController: PriceViewController
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
        func makeUIViewController(context: Context) -> some UIViewController {
            return priceViewController
        }
    }
    
    func getRepresentable() -> some View {
        VCRepresentable(priceViewController: self)
    }
}


