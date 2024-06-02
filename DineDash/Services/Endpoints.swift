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
    
    var stringValue: String {
        switch self {
        case .getFoodList:
            return EndPoints.BASE_URL + "/tumYemekleriGetir.php"
        case .getFoodImages:
            return EndPoints.BASE_URL + "/resimler"
        }
    }
    
    var url: URL {
        return URL(string: stringValue)!
    }
}
