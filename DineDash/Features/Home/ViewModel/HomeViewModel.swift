//
//  HomeViewModel.swift
//  DineDash
//
//  Created by Emre Yeşilyurt on 29.05.2024.
//

import Foundation

final class HomeViewModel {
    private  var products: [Product]? = MockData.products
    private  var filteredProducts: [Product]?
    
    func fetchProducts() {
        products = MockData.products
        filteredProducts = products
    }
    
    func getProductCount() -> Int {
        filteredProducts?.count ?? 0
    }
    
    func getProduct(at index: Int) -> Product? {
        filteredProducts?[index]
    }
    
    func searchProduct(searchText: String) {
        filteredProducts = []
        if searchText == "" {
            filteredProducts = products
        } else {
            guard let products = products else { return }
            for product in products {
                if product.name.lowercased().contains(searchText.lowercased()) {
                    filteredProducts?.append(product)
                }
            }
        }
    }
}
