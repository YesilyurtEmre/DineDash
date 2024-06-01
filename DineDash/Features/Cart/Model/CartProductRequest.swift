//
//  CartProduct.swift
//  DineDash
//
//  Created by Emre Yeşilyurt on 1.06.2024.
//

import Foundation

struct CartProductRequest: Encodable {
    let yemekAdi: String
    let yemekResimAdi: String
    let yemekFiyat, yemekSiparisAdet: Int
    let kullaniciAdi: String
    
    enum CodingKeys: String, CodingKey {
        case yemekAdi = "yemek_adi"
        case yemekResimAdi = "yemek_resim_adi"
        case yemekFiyat = "yemek_fiyat"
        case yemekSiparisAdet = "yemek_siparis_adet"
        case kullaniciAdi = "kullanici_adi"
    }
}

