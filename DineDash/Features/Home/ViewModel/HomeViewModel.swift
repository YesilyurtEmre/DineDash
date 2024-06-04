//
//  HomeViewModel.swift
//  DineDash
//
//  Created by Emre Yeşilyurt on 29.05.2024.
//

import UIKit
import Alamofire
import AlamofireImage

protocol HomeViewModelProtocol {
    var delegate: HomeViewModelDelegate? {get set}
    func saveFood(food: FavoriteFoods, completion: @escaping (Bool, String?) -> ())
    func foodIsFavorite(index: Int) -> Bool
}

protocol HomeViewModelDelegate: AnyObject {
    func foodsLoaded()
    func foodsFailed(error: Error)
}

final class HomeViewModel: HomeViewModelProtocol {
    weak var delegate: HomeViewModelDelegate?
    private var foods: [Food]? = MockData.foods
    var filteredFoods: [Food]?
    var foodImages: [String: UIImage] = [:]
    
    init() {
        fetchFoods()
    }
    
    func fetchFoods() {
        
        let urlString = EndPoints.getFoodList.stringValue
        APIRequest.shared.get(url: urlString) { [weak self] (result: Result<FoodsResponse, AFError>) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                guard let self else {return}
                switch result {
                case .success(let response):
                    self.foods = response.yemekler
                    self.filteredFoods = self.foods
                    self.fetchFoodImages()
                    self.delegate?.foodsLoaded()
                case .failure(let error):
                    self.delegate?.foodsFailed(error: error)
                }
            }
            
        }
    }
    
    private func fetchFoodImages() {
        let group = DispatchGroup()
        
        for food in filteredFoods! {
            group.enter()
            let imageURL = "\(EndPoints.getFoodImages.stringValue)/\(food.yemekResimAdi)"
            AF.request(imageURL).responseImage { response in
                if case .success(let image) = response.result {
                    self.foodImages[food.yemekId] = image
                } else {
                    print("Error fetching image for food id \(food.yemekId): \(String(describing: response.error))")
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.delegate?.foodsLoaded()
        }
    }
    
    func saveFood(food: FavoriteFoods, completion: @escaping (Bool, String?) -> ()) {
        FavoritesFoodManager.shared.saveData(data: food) { [weak self] isSuccess, saveError in
            guard let self = self else { return }
            if isSuccess {
                self.delegate?.foodsLoaded()
                completion(true, nil)
            } else {
                completion(false, saveError.rawValue)
            }
        }
    }
    
    func getProductCount() -> Int {
        filteredFoods?.count ?? 0
    }
    
    func getProduct(at index: Int) -> Food? {
        filteredFoods?[index]
    }
    
    func searchProduct(searchText: String) {
        filteredFoods = []
        if searchText == "" {
            filteredFoods = foods
        } else {
            guard let foods = foods else { return }
            for food in foods {
                if food.yemekAdi.lowercased().contains(searchText.lowercased()) {
                    filteredFoods?.append(food)
                }
            }
        }
    }
    
    func foodIsFavorite(index: Int) -> Bool {
        filteredFoods?[index].isFavorite ?? false
    }
}
