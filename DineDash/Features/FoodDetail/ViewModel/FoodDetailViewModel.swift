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
}
