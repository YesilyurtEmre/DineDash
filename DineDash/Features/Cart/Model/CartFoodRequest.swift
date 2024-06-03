//
//  CartFoodRequest.swift
//  DineDash
//
//  Created by Emre Yeşilyurt on 1.06.2024.
//

import Foundation

struct CartFoodRequest: Encodable {
    let yemekAdi: String
    let yemekResimAdi: String
    let yemekFiyat, yemekSiparisAdet: String
    let kullaniciAdi: String
    
    enum CodingKeys: String, CodingKey {
        case yemekAdi = "yemek_adi"
        case yemekResimAdi = "yemek_resim_adi"
        case yemekFiyat = "yemek_fiyat"
        case yemekSiparisAdet = "yemek_siparis_adet"
        case kullaniciAdi = "kullanici_adi"
    }
}

