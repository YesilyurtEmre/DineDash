//
//  FoodCell.swift
//  DineDash
//
//  Created by Emre Yeşilyurt on 27.05.2024.
//

import UIKit
import SwiftAlertView
import MaterialActivityIndicator


class FoodCell: UICollectionViewCell {
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var productImgView: UIImageView!
    @IBOutlet weak var favButton: UIButton!
    
    var indexPath: IndexPath?
    var foodId: Int?
    private var homeViewModel: HomeViewModelProtocol = HomeViewModel()
    private var favoriteFoodListViewModel = FavoriteFoodListViewModel()
    
    
    @IBAction func favButtonTapped(_ sender: UIButton) {
        if homeViewModel.foodIsFavorite(index: indexPath?.row ?? 0) {
            guard let foodId = foodId else { return }
            favoriteFoodListViewModel.deleteFood(foodId: foodId) { [weak self] isSuccess, deleteError in
                guard let self = self else { return }
                if isSuccess {
                    self.favButton.setImage(UIImage(systemName: "heart"), for: .normal)
                    NotificationCenter.default.post(name: NSNotification.Name("deleteData"), object: nil)
                } else {
                    guard let deleteError = deleteError else { return }
                    //                    self.showErrorAlert(message: deleteError) {
                    //                        self.indicator.stopAnimating()
                    //                    }
                }
            }
        } else {
            let favoriteFood = createNewFavoriteFood()
            favoriteFoodListViewModel.saveFood(food: favoriteFood) { [weak self] isSuccess, saveError in
                guard let self = self else { return }
                if isSuccess {
                    self.favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                } else {
                    guard let saveError = saveError else { return }
                    //                    self.SwiftAlertView(message: saveError) {
                    //                        self.indicator.stopAnimating()
                    //                    }
                }
            }
        }
    }
    
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
       
    }
    
    private func createNewFavoriteFood() -> FavoriteFoods {
        let newFood = FavoriteFoods(context: FavoritesFoodManager.shared.context)
        newFood.setValue(foodId, forKey: "foodId")
        newFood.setValue(nameLabel.text, forKey: "name")
        newFood.setValue(priceLabel.text, forKey: "price")
        newFood.setValue(Date(), forKey: "createdAt")
        guard let imageData = productImgView.image else { return newFood }
        newFood.setValue(imageData.pngData(), forKey: "image")
        return newFood
    }
}
