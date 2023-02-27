//
//  UICollectionViewCell+Datasource.swift
//  DogeCoinFetch-iOS
//
//  Created by BOONGKI KWAK on 2023/02/27.
//

import UIKit

extension PriceViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = coinCollectionView.dequeueReusableCell(withReuseIdentifier: CoinCell.reuseIdentifier, for: indexPath) as! CoinCell
        
        var currentButtonTitle: String = ""
        //currencyOutletCollection.forEach { currentButtonTitle = $0.isSelected == true ? $0.titleLabel!.text! : ""}
        for button in currencyOutletCollection {
            if button.isSelected {
                currentButtonTitle = button.titleLabel!.text!
            }
        }
        print("currentButtonTitle = \(currentButtonTitle)")
        cell.coinSymbolLabel.text = "DOGE/\(currentButtonTitle)"
        let priceDouble = Double(dogeCoinPrice[currentButtonTitle]!)!
        switch currentButtonTitle {
        case "KRW": cell.coinPriceLabel.text = String(format: "%.2f", priceDouble)
        case "BTC": cell.coinPriceLabel.text = String(format: "%.8f", priceDouble)
        case "ETH": cell.coinPriceLabel.text = String(format: "%.8f", priceDouble)
        case "USD": cell.coinPriceLabel.text = String(format: "%.6f", priceDouble)
        default: print("nothing isSelected")
        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let coinHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CoinHeaderView.reuseIdentifier, for: indexPath) as? CoinHeaderView else {
            fatalError("Cannot create CoinHeaderView")
        }
        return coinHeaderView
    }
    
}
