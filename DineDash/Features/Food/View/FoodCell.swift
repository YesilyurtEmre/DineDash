//
//  FoodCell.swift
//  DineDash
//
//  Created by Emre Yeşilyurt on 27.05.2024.
//

import UIKit
import SwiftAlertView
import MaterialActivityIndicator

protocol FoodCellDelegate: AnyObject {
    func didTapFavoriteButton(foodId: Int32)
}

class FoodCell: UICollectionViewCell {
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var productImgView: UIImageView!
    @IBOutlet weak var favButton: UIButton!
    
    var indexPath: IndexPath?
    var isFavorite: Bool = false {
        didSet {
            updateFavButton()
        }
    }
    var foodId: Int?
    var delegate: FoodCellDelegate?
    var addButtonHandler: (() -> Void)?
    
    
    @IBAction func favButtonTapped(_ sender: UIButton) {
        guard let indexPath else { return }
        NotificationCenter.default.post(name: Notification.Name("FavoriteButtonTapped"), object: indexPath)
    }
    
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        addButtonHandler?()
    }
    
    private func updateFavButton() {
        let imageName = isFavorite ? "heart.fill" : "heart"
        favButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
}
