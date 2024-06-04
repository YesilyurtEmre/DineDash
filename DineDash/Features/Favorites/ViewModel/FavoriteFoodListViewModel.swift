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

final class FavoriteFoodListViewModel {
    
    weak var delegate: FavoriteFoodListViewModelDelegate?
    private var favoriteFoods: [FavoriteFoods]?
    
    func getFoodCount() -> Int {
        favoriteFoods?.count ?? 0
    }
    
    func getFood(at index: Int) -> FavoriteFoods? {
        favoriteFoods?[index]
    }
}
