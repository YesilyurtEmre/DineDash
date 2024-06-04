//
//  FavoriteFoodListViewModel.swift
//  DineDash
//
//  Created by Emre Yeşilyurt on 4.06.2024.
//

import Foundation

protocol FavoriteFoodListViewModelProtocol {
    var delegate: FavoriteFoodListViewModelDelegate? { get set }
    func fetchFoods(completion: @escaping (_ isSuccess: Bool, String?) -> ())
    func saveFood(food: FavoriteFoods, completion: @escaping (Bool, String?) -> ())
    func deleteFood(foodId: Int, completion: @escaping (Bool, String?) -> ())
    func getFoodCount() -> Int
    func getFood(at index: Int) -> FavoriteFoods?
}

protocol FavoriteFoodListViewModelDelegate: AnyObject {
    func foodsLoaded()
    func foodsFailed(error: Error)
}

final class FavoriteFoodListViewModel: FavoriteFoodListViewModelProtocol {
    
    weak var delegate: FavoriteFoodListViewModelDelegate?
    private var favoriteFoods: [FavoriteFoods]?
    
    func fetchFoods(completion: @escaping (_ isSuccess: Bool, String?) -> ()) {
        FavoritesFoodManager.shared.fetchData { [weak self] foods, fetchError in
            guard let self = self else { return }
            if fetchError == .noError {
                guard let foods = foods else { return }
                self.favoriteFoods = foods
                self.delegate?.foodsLoaded()
                completion(true, nil)
            } else {
                if self.getFoodCount() == 1 {
                    self.favoriteFoods?.removeAll()
                }
                self.delegate?.foodsLoaded()
                completion(false, fetchError.rawValue)
            }
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
    
    func deleteFood(foodId: Int, completion: @escaping (Bool, String?) -> ()) {
        FavoritesFoodManager.shared.deleteData(id: foodId) { [weak self] isSuccess, deleteError in
            guard let self = self else { return }
            if isSuccess {
                self.delegate?.foodsLoaded()
                completion(true, nil)
            } else {
                completion(false, deleteError.rawValue)
            }
        }
    }
    
    func getFoodCount() -> Int {
        favoriteFoods?.count ?? 0
    }
    
    func getFood(at index: Int) -> FavoriteFoods? {
        favoriteFoods?[index]
    }
}
