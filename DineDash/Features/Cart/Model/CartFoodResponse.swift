//
//  CartFoodResponse.swift
//  DineDash
//
//  Created by Emre Yeşilyurt on 1.06.2024.
//

import Foundation

// MARK: - CartFoodResponse
struct CartFoodResponse: Codable {
    let sepet_yemekler: [CartFood]?
    var success: Int?
}

struct CartFood: Codable {
    let sepetYemekId: String
    let yemekAdi: String
    let yemekResimAdi: String
    let yemekFiyat, yemekSiparisAdet: String
    let kullaniciAdi: String
    
    enum CodingKeys: String, CodingKey {
        case sepetYemekId = "sepet_yemek_id"
        case yemekAdi = "yemek_adi"
        case yemekResimAdi = "yemek_resim_adi"
        case yemekFiyat = "yemek_fiyat"
        case yemekSiparisAdet = "yemek_siparis_adet"
        case kullaniciAdi = "kullanici_adi"
    }
}

struct CartProductMockData {
    static let sampleProductAyran = CartFood(
        sepetYemekId: "1",
        yemekAdi: "Ayran",
        yemekResimAdi: "Ayran",
        yemekFiyat: "10",
        yemekSiparisAdet: "3",
        kullaniciAdi: "Emre"
    )
    static let sampleProductKola = CartFood(
        sepetYemekId: "2",
        yemekAdi: "Coca Cola",
        yemekResimAdi: "Kola",
        yemekFiyat: "10",
        yemekSiparisAdet: "4",
        kullaniciAdi: "Emre"
    )
    static let products = [sampleProductAyran,sampleProductKola]
}
