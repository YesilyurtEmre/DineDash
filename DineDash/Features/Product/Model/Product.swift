//
//  Product.swift
//  DineDash
//
//  Created by Emre Yeşilyurt on 27.05.2024.
//

import Foundation

struct Product {
    let id:Int?
    let name:String
    let image:String?
    let price:Int?
}

struct MockData {
    static let sampleProductAyran = Product(
        id: 1,
        name: "Ayran",
        image: "Ayran",
        price: 10
    )
    static let sampleProductKola = Product(
        id: 2,
        name: "Coca Cola",
        image: "Kola",
        price: 10
    )
    static let sampleProductBiftek = Product(
        id: 3,
        name: "Biftek",
        image: "biftek",
        price: 10
    )
    static let sampleProductSoda = Product(
        id: 4,
        name: "Sade Soda",
        image: "Soda",
        price: 10
    )
    static let sampleProductSu = Product(
        id: 5,
        name: "Su",
        image: "Su",
        price: 10
    )
    static let sampleProductSalgam = Product(
        id: 6,
        name: "Şalgam",
        image: "şalgam",
        price: 10
    )
    static let sampleProductBaklava = Product(
        id: 7,
        name: "Baklava",
        image: "baklava",
        price: 10
    )
    
    static let products = [
        sampleProductAyran,
        sampleProductKola,
        sampleProductBiftek,
        sampleProductSoda,
        sampleProductSu,
        sampleProductSalgam,
        sampleProductBaklava,
    ]
}
