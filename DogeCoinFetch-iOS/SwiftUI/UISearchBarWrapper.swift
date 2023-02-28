//
//  UISearchBarWrapper.swift
//  DogeCoinFetch-iOS
//
//  Created by BOONGKI KWAK on 2023/02/28.
//

import SwiftUI
import UIKit

struct UISearchBarWrapper: UIViewRepresentable {
    
    static var searchBar = UISearchBar()
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
         
    }
    
    func makeUIView(context: Context) -> some UIView {
        return UISearchBarWrapper.searchBar
    }
    
    func updatePlaceholder(_ text: String) {
        UISearchBarWrapper.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: text)
    }
    
    
}
