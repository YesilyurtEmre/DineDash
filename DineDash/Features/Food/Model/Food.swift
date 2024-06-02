//
//  Food.swift
//  DineDash
//
//  Created by Emre Yeşilyurt on 27.05.2024.
//

import Foundation

struct FoodsResponse: Decodable {
    let yemekler: [Food]
}

// MARK: - Yemekler
struct Food: Decodable {
    let yemekId: String
    let yemekAdi: String
    let yemekResimAdi: String
    let yemekFiyat: String

    enum CodingKeys: String, CodingKey {
        case yemekId = "yemek_id"
        case yemekAdi = "yemek_adi"
        case yemekResimAdi = "yemek_resim_adi"
        case yemekFiyat = "yemek_fiyat"
    }
}

struct MockData {
    static let sampleProductAyran = Food(
        yemekId: "1",
        yemekAdi: "Ayran",
        yemekResimAdi: "Ayran",
        yemekFiyat: "10"
    )
    static let sampleProductKola = Food(
        yemekId: "2",
        yemekAdi: "Coca Cola",
        yemekResimAdi: "Kola",
        yemekFiyat: "10"
    )
    static let sampleProductBiftek = Food(
        yemekId: "3",
        yemekAdi: "Biftek",
        yemekResimAdi: "biftek",
        yemekFiyat: "10"
    )
    static let sampleProductSoda = Food(
        yemekId: "4",
        yemekAdi: "Sade Soda",
        yemekResimAdi: "Soda",
        yemekFiyat: "10"
    )
    static let sampleProductSu = Food(
        yemekId: "5",
        yemekAdi: "Su",
        yemekResimAdi: "Su",
        yemekFiyat: "10"
    )
    static let sampleProductSalgam = Food(
        yemekId: "6",
        yemekAdi: "Şalgam",
        yemekResimAdi: "şalgam",
        yemekFiyat: "10"
    )
    static let sampleProductBaklava = Food(
        yemekId: "7",
        yemekAdi: "Baklava",
        yemekResimAdi: "baklava",
        yemekFiyat: "10"
    )
    
    static let foods = [
        sampleProductAyran,
        sampleProductKola,
        sampleProductBiftek,
        sampleProductSoda,
        sampleProductSu,
        sampleProductSalgam,
        sampleProductBaklava,
    ]
}
