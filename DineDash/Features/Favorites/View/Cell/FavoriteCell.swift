//
//  FavoriteCell.swift
//  DineDash
//
//  Created by Emre Yeşilyurt on 4.06.2024.
//

import UIKit

protocol FavoriteCellDelegate: AnyObject {
    func didTapFavoriteButton(foodId: Int32)
}

class FavoriteCell: UITableViewCell {
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var foodPriceLabel: UILabel!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodImageView: UIImageView!
    
    var foodId: Int32?
    var delegate: FavoriteCellDelegate?
    //var foodDelegate: FoodCellDelegate?
    var indexPath: IndexPath?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        guard let foodId = foodId else { return }
                delegate?.didTapFavoriteButton(foodId: foodId)
    }
}
