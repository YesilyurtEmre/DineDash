//
//  FoodDetailViewModel.swift
//  DineDash
//
//  Created by Emre Yeşilyurt on 2.06.2024.
//

import UIKit
import Alamofire
import AlamofireImage

protocol FoodDetailViewModelProtocol {
    var delegate: FoodDetailViewModelDelegate? {get set}
}

protocol FoodDetailViewModelDelegate: AnyObject {
    func imageLoaded()
    func imageLoadFailed(error: Error)
    func foodsAdded()
    func foodsAddedFailed(error: Error)
}

final class FoodDetailViewModel {
    
    weak var delegate: FoodDetailViewModelDelegate?
    var foodDetailImage: UIImage?
    
    init(foodImage: String) {
        fetchFoodImage(foodImage: foodImage)
    }
    
    private func fetchFoodImage(foodImage: String) {
        let imageURL = "\(EndPoints.getFoodImages.stringValue)/\(foodImage)"
        AF.request(imageURL).responseImage { response in
            if case .success(let image) = response.result {
                self.foodDetailImage = image
                self.delegate?.imageLoaded()
            } else {
                self.delegate?.imageLoadFailed(error: "Error fetching image" as! Error)
            }
        }
    }
    
    func addToCart(food: CartFoodRequest) {
            let params: Parameters = [
                "yemek_adi": food.yemekAdi,
                "yemek_fiyat": food.yemekFiyat,
                "yemek_resim_adi": food.yemekResimAdi,
                "yemek_siparis_adet": food.yemekSiparisAdet,
                "kullanici_adi": food.kullaniciAdi
            ]
            let urlString = EndPoints.addFoodToCart.stringValue
            APIRequest.shared.post(url: urlString, parameters: params) { [weak self] (result: Result<AddToCartResponse, AFError>) in
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    guard let self else {return}
                    switch result {
                    case .success(let response):
                        if response.success == 0 {
                            self.delegate?.foodsAdded()
                        }
                    case .failure(let error):
                        self.delegate?.foodsAddedFailed(error: error)
                    }
                }
            }
        }
}
