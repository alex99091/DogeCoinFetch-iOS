//
//  CoinCell.swift
//  DogeCoinFetch-iOS
//
//  Created by BOONGKI KWAK on 2023/02/27.
//

import UIKit

class CoinCell: UICollectionViewCell {
    
    // IB OUtlet
    @IBOutlet weak var coinNameLabel: UILabel!
    @IBOutlet weak var coinSymbolLabel: UILabel!
    @IBOutlet weak var coinPriceLabel: UILabel!
    @IBOutlet weak var coinChangeLabel: UILabel!
    
    // Property
    static let reuseIdentifier = String(describing: CoinCell.self)

    // Life Cycle
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}
