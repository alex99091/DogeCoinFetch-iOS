//
//  PriceView.swift
//  DogeCoinFetch-iOS
//
//  Created by BOONGKI KWAK on 2023/02/27.
//

import UIKit
import SwiftUI

struct PriceView: View {
    
    // Property
    @StateObject var priceViewModel = PriceViewModel()
    //var priceViewModel = PriceViewModel()
    @State var currentDogeCoinPrice: [String: String] = ["KRW": "108.10","ETH": "0.00004995","USD": "0.081","BTC": "0.00000352"]
    let yesterdayDogeCoinPrice: [String: String] = ["KRW": "109.10","ETH": "0.00005120","USD": "0.083","BTC": "0.00000362"]
    @State var coinPriceLabel: [String: String] = ["NAME": "", "PRICE": "", "CHANGE": ""]
    @State private var selectedButton: String? = "KRW"
    
    let buttonTintcolor = UIColor(rgb: 0x000080)
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 10) {
                let maxWidth = geometry.size.width - 40
                let leadingSpacing = CGFloat(10.0)
                let trailingSpacing = CGFloat(10.0)
                titleView
                    .frame(width: maxWidth - leadingSpacing, height: 60, alignment: .center)
                searchBarView()
                    .frame(width: maxWidth - (leadingSpacing-trailingSpacing)*2, height: 25, alignment: .leading)
                    .padding(EdgeInsets(top:0, leading: leadingSpacing*2, bottom: 0, trailing: trailingSpacing*2))
                buttonMenusView
                    .frame(width: maxWidth - (leadingSpacing-trailingSpacing)*2, height: 60, alignment: .leading)
                    .padding(EdgeInsets(top:0, leading: leadingSpacing*2, bottom: 0, trailing: trailingSpacing*2))
                coinLabelView
                    .frame(width: maxWidth - (leadingSpacing-trailingSpacing)*2, height: 40, alignment: .leading)
                    .padding(EdgeInsets(top:0, leading: leadingSpacing*2, bottom: 0, trailing: trailingSpacing*2))
                Spacer()
            }
        }
        .onReceive(priceViewModel.$dogeCoinPrice) { dogeCoinPrice in
            currentDogeCoinPrice = dogeCoinPrice
            print("currentDogeCoinPrice: \(currentDogeCoinPrice)")
        }
    }
    
    // TitleView
    var titleView: some View {
        Text("거래소")
            .font(.system(size: 24, weight: .bold))
            .foregroundColor(Color.init(uiColor: buttonTintcolor))
            .frame(alignment: .center)
    }
    
    // UISearchBarView
    func searchBarView() -> some View {
        let searchBar = UISearchBarWrapper()
        let placeholderString = "코인명 검색"
        searchBar.updatePlaceholder(placeholderString)
        return searchBar
    }
    
    var buttonMenusView: some View {
        VStack{
            Spacer()
            HStack(spacing: 15){
                let priceDouble = Double(currentDogeCoinPrice["KRW"]!)!
                let change = (priceDouble / Double(yesterdayDogeCoinPrice["KRW"]!)! - 1) * 100
                Button(action: {
                    selectedButton = "KRW"
                    coinPriceLabel.updateValue("DOGE/KRW", forKey: "NAME")
                    coinPriceLabel.updateValue(String(format: "%.2f", priceDouble), forKey: "PRICE")
                    coinPriceLabel.updateValue(String(format: "%.2f ", change) + "%", forKey: "CHANGE")
                }, label: {
                    Text("KRW")
                        .font(.system(size: 18))
                        .foregroundColor(selectedButton == "KRW" ? .white : Color.init(uiColor: buttonTintcolor))
                })
                .frame(alignment: .leading)
                .background(selectedButton == "KRW" ? Color.blue : Color.clear)
                .cornerRadius(5)
                
                Button(action: {
                    selectedButton = "BTC"
                    let priceDouble = Double(currentDogeCoinPrice["BTC"]!)!
                    let change = (priceDouble / Double(yesterdayDogeCoinPrice["BTC"]!)! - 1) * 100
                    coinPriceLabel.updateValue("DOGE/BTC", forKey: "NAME")
                    coinPriceLabel.updateValue(String(format: "%.8f", priceDouble), forKey: "PRICE")
                    coinPriceLabel.updateValue(String(format: "%.2f ", change) + "%", forKey: "CHANGE")
                }, label: {
                    Text("BTC")
                        .font(.system(size: 18))
                        .foregroundColor(selectedButton == "BTC" ? .white : Color.init(uiColor: buttonTintcolor))
                })
                .frame(alignment: .leading)
                .background(selectedButton == "BTC" ? Color.blue : Color.clear)
                .cornerRadius(5)
                
                Button(action: {
                    selectedButton = "USD"
                    let priceDouble = Double(currentDogeCoinPrice["USD"]!)!
                    let change = (priceDouble / Double(yesterdayDogeCoinPrice["USD"]!)! - 1) * 100
                    coinPriceLabel.updateValue("DOGE/USD", forKey: "NAME")
                    coinPriceLabel.updateValue(String(format: "%.6f", priceDouble), forKey: "PRICE")
                    coinPriceLabel.updateValue(String(format: "%.2f ", change) + "%", forKey: "CHANGE")
                }, label: {
                    Text("USD")
                        .font(.system(size: 18))
                        .foregroundColor(selectedButton == "USD" ? .white : Color.init(uiColor: buttonTintcolor))
                })
                .frame(alignment: .leading)
                .background(selectedButton == "USD" ? Color.blue : Color.clear)
                .cornerRadius(5)
                
                Button(action: {
                    selectedButton = "ETH"
                    let priceDouble = Double(currentDogeCoinPrice["ETH"]!)!
                    let change = (priceDouble / Double(yesterdayDogeCoinPrice["ETH"]!)! - 1) * 100
                    coinPriceLabel.updateValue("DOGE/ETH", forKey: "NAME")
                    coinPriceLabel.updateValue(String(format: "%.8f", priceDouble), forKey: "PRICE")
                    coinPriceLabel.updateValue(String(format: "%.2f ", change) + "%", forKey: "CHANGE")
                }, label: {
                    Text("ETH")
                        .font(.system(size: 18))
                        .foregroundColor(selectedButton == "ETH" ? .white : Color.init(uiColor: buttonTintcolor))
                })
                .frame(alignment: .leading)
                .background(selectedButton == "ETH" ? Color.blue : Color.clear)
                .cornerRadius(5)
            }
            Spacer()
        }
    }
    
    var coinLabelView: some View {
        VStack(spacing: 5) {
            HStack {
                Text("한글명")
                    .font(.system(size: 16)).foregroundColor(Color.gray)
                    .frame(width: 110, height: 15, alignment: .leading)
                Text("현재가")
                    .font(.system(size: 16)).foregroundColor(Color.gray)
                    .frame(width: 110, height: 15, alignment: .center)
                Text("전일대비")
                    .font(.system(size: 16)).foregroundColor(Color.gray)
                    .frame(width: 110, height: 15, alignment: .center)
            }
            HStack {
                VStack {
                    Spacer()
                    Text("도지").font(.system(size: 15))
                        .foregroundColor(Color.blue)
                        .frame(width: 110, height: 10, alignment: .leading)
                    Text(coinPriceLabel["NAME"]!).font(.system(size: 8))
                        .foregroundColor(Color.blue)
                        .frame(width: 110, height: 10, alignment: .leading)
                    Spacer()
                }
                Text(coinPriceLabel["PRICE"]!)
                    .font(.system(size: 14)).foregroundColor(Color.red)
                    .frame(width: 110, height: 15, alignment: .center)
                Text(coinPriceLabel["CHANGE"]!)
                    .font(.system(size: 14)).foregroundColor(Color.red)
                    .frame(width: 110, height: 15, alignment: .center)
            }
        }
    }
    // CoinInformationView
    var coinInformationView: some View {
        HStack(spacing: 0) {
            VStack(spacing: 0){
                Spacer()
                Text("한글명")
                    .font(.system(size: 16)).foregroundColor(Color.gray)
                    .frame(width: 100, height: 15, alignment: .leading)
                Text("DOGE/KRW").font(.system(size: 12))
                    .foregroundColor(Color.blue)
                    .frame(width: 100, height: 15, alignment: .leading)
                Spacer()
            }
            Spacer()
            VStack{
                Spacer()
                Text("현재가")
                    .font(.system(size: 16)).foregroundColor(Color.gray)
                    .frame(width: 100, height: 15, alignment: .center)
                Text("105.05")
                    .font(.system(size: 16)).foregroundColor(Color.red)
                    .frame(width: 100, height: 15, alignment: .center)
                Spacer()
            }
            Spacer()
            VStack{
                Spacer()
                Text("전일대비")
                    .font(.system(size: 16)).foregroundColor(Color.gray)
                    .frame(width: 100, height: 15, alignment: .center)
                Text("-2.78%")
                    .font(.system(size: 16)).foregroundColor(Color.red)
                    .frame(width: 100, height: 15, alignment: .center)
                Spacer()
            }
        }
    }
}

struct PriceView_Previews: PreviewProvider {
    static var previews: some View {
        PriceView()
    }
}
