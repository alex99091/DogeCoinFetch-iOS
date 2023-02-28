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
    var websocketTask: URLSessionWebSocketTask
    
    var dogeCoinPrice: [String: String] = ["KRW": "105.05","ETH": "0.00005050","USD": "0.08120","BTC": "0.00000350"]
    var yesterdayDogeCoinPrice: [String: String] = ["KRW": "108.10","ETH": "0.00004995","USD": "0.081","BTC": "0.00000352"]
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
                buttonMenuView
                    .frame(width: maxWidth - (leadingSpacing-trailingSpacing)*2, height: 60, alignment: .leading)
                    .padding(EdgeInsets(top:0, leading: leadingSpacing*2, bottom: 0, trailing: trailingSpacing*2))
                coinLabelView
                    .frame(width: maxWidth - (leadingSpacing-trailingSpacing)*2, height: 40, alignment: .leading)
                    .padding(EdgeInsets(top:0, leading: leadingSpacing*2, bottom: 0, trailing: trailingSpacing*2))
                Spacer()
            }
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
    
    // ButtonMenuView
    var buttonMenuView: some View {
        VStack{
            Spacer()
            HStack(spacing: 15){
                Button(action: { }, label: { Text("KRW").font(.system(size: 18)).foregroundColor(Color.init(uiColor: buttonTintcolor))})
                    .frame(alignment: .leading)
                Button(action: { }, label: { Text("BTC").font(.system(size: 18)).foregroundColor(Color.init(uiColor: buttonTintcolor))})
                    .frame(alignment: .leading)
                Button(action: { }, label: { Text("USD").font(.system(size: 18)).foregroundColor(Color.init(uiColor: buttonTintcolor))})
                    .frame(alignment: .leading)
                Button(action: { }, label: { Text("ETH").font(.system(size: 18)).foregroundColor(Color.init(uiColor: buttonTintcolor))})
                    .frame(alignment: .leading)
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
                    Text("도지").font(.system(size: 14))
                        .foregroundColor(Color.blue)
                        .frame(width: 110, height: 10, alignment: .leading)
                    Text("DOGE/KRW").font(.system(size: 8))
                        .foregroundColor(Color.blue)
                        .frame(width: 110, height: 10, alignment: .leading)
                    Spacer()
                }
                Text("105.05")
                    .font(.system(size: 14)).foregroundColor(Color.red)
                    .frame(width: 110, height: 15, alignment: .center)
                Text("-2.78%")
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
