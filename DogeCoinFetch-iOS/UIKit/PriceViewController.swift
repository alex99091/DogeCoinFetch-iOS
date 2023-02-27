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
    
    // Property
    var dogeCoin: DogeCoin = DogeCoin()
    
    // Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.coinCollectionView.register(CoinCell.uinib, forCellWithReuseIdentifier: CoinCell.reuseIdentifier)
        self.coinCollectionView.dataSource = self
        self.coinCollectionView.delegate = self
        openWebSocket()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            print("executed")
            self.requestPrice()
        })
        
    }
    
    // Method
    func openWebSocket() {
        let urlString = "wss://ws.dogechain.info/inv"
        WebSocket.shared.url = URL(string: urlString)
        try? WebSocket.shared.openWebSocket()
        WebSocket.shared.delegate = self
    }
    func requestPrice() {
        let message = "op"
        //let message = "{\"op\":\"price_sub\"}"
        WebSocket.shared.send(message: message)
        WebSocket.shared.receive(onReceive: { (string, data) in
            print("success")
            print("(string, data): (\(String(describing: string)), \(String(describing: data))")
        })
        
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


