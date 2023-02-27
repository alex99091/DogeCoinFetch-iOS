//
//  PriceViewController.swift
//  DogeCoinFetch-iOS
//
//  Created by BOONGKI KWAK on 2023/02/27.
//

import UIKit
import SwiftUI

class PriceViewController: UIViewController {
    
    // IB Outlet
    @IBOutlet weak var coinCollectionView: UICollectionView!
    
    // Property
    
    
    // Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.coinCollectionView.register(CoinCell.uinib, forCellWithReuseIdentifier: CoinCell.reuseIdentifier)
        self.coinCollectionView.dataSource = self
        self.coinCollectionView.delegate = self
        
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


