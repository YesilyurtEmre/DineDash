//
//  CartCell.swift
//  DineDash
//
//  Created by Emre Yeşilyurt on 1.06.2024.
//

import UIKit

class CartCell: UITableViewCell {
    
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productCount: UILabel!
    @IBOutlet weak var totalPrice: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(product: CartProductResponse) {
        let totalProductPrice = product.yemekFiyat * product.yemekSiparisAdet
        productImageView.image = UIImage(named: product.yemekResimAdi)
        productName.text = product.yemekAdi
        productPrice.text = "\(product.yemekFiyat)"
        productCount.text = "\(product.yemekSiparisAdet)"
        totalPrice.text = "\(totalProductPrice)"
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
    }
    
}
