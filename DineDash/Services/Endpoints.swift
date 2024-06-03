//
//  Endpoints.swift
//  DineDash
//
//  Created by Emre Yeşilyurt on 1.06.2024.
//

import Foundation

enum EndPoints {
    static private let BASE_URL = "http://kasimadalan.pe.hu/yemekler"
    
    case getFoodList
    case getFoodImages
    case addFoodToCart
    case getFoodToCart
    
    var stringValue: String {
        switch self {
        case .getFoodList:
            return EndPoints.BASE_URL + "/tumYemekleriGetir.php"
        case .getFoodImages:
            return EndPoints.BASE_URL + "/resimler"
        case .addFoodToCart:
            return EndPoints.BASE_URL + "/sepeteYemekEkle.php"
        case .getFoodToCart:
            return EndPoints.BASE_URL + "/sepettekiYemekleriGetir.php"
        }
    }
    
    var url: URL {
        return URL(string: stringValue)!
    }
}
