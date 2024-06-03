//
//  CartViewModel.swift
//  DineDash
//
//  Created by Emre Yeşilyurt on 1.06.2024.
//

import UIKit
import Alamofire
import AlamofireImage

protocol CartViewModelProtocol {
    var delegate: CartViewModelDelegate? {get set}
}

protocol CartViewModelDelegate: AnyObject {
    func getFoodToCart()
    func getFoodToCartFailed(error: Error)
}

final class CartViewModel {
    weak var delegate: CartViewModelDelegate?
    
    var cartItems: [CartFoodResponse] = []
    
    init() {
        getFoodToCart()
    }
    
    func getFoodToCart() {
        let urlString = EndPoints.getFoodToCart.stringValue
        let params: Parameters = ["kullanici_adi": "emre_yesilyurt"]
        APIRequest.shared.post(url: urlString, parameters: params) { [weak self] (result: Result<CartFoodResponse, AFError>) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                guard let self else {return}
                switch result {
                case .success(let response):
                    self.cartItems = [response]
                    self.delegate?.getFoodToCart()
                case .failure(let error):
                    self.delegate?.getFoodToCartFailed(error: error)
                }
            }
        }
    }
}
