//
//  ProductDetailVC.swift
//  DineDash
//
//  Created by Emre Yeşilyurt on 29.05.2024.
//

import UIKit

final class FoodDetailVC: BaseVC {
    
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var detailTotalPriceLabel: UILabel!
    @IBOutlet weak var orderCountLabel: UILabel!
    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var detailPriceLabel: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var favButton: UIButton!
    
    var selectedFood: Food?
    
    var viewModel: FoodDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let food = selectedFood else { return }
        configureUI(food: food)
        updateProductNumberLabel()
        updateDetailTotalPriceLabel()
        stepper.addTarget(self, action: #selector(stepperValueChanged), for: .valueChanged)
        viewModel = FoodDetailViewModel(foodImage: food.yemekResimAdi)
        viewModel?.delegate = self
        indicator.startAnimating()
    }
    
    private func configureUI(food: Food) {
        //guard let selectedFood else {return}
        orderCountLabel.text = "0"
        detailNameLabel.text = food.yemekAdi
        detailPriceLabel.text = food.yemekFiyat + "₺"
        detailImageView.image = UIImage(named: food.yemekResimAdi)
        let imageName = food.isFavorite ? "heart.fill" : "heart"
        favButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    func updateDetailTotalPriceLabel() {
        guard let selectedFood = selectedFood else {
            return
        }
        let totalPrice = (Double(selectedFood.yemekFiyat) ?? 0) * (Double(orderCountLabel.text ?? "0") ?? 0)
        
        detailTotalPriceLabel.text = String("\(Int(totalPrice)) ₺")
    }
    
    @objc func stepperValueChanged() {
        updateProductNumberLabel()
        updateDetailTotalPriceLabel()
    }
    
    func updateProductNumberLabel() {
        orderCountLabel.text = "\(Int(stepper.value))"
    }
    
    @IBAction func stepperChange(_ sender: UIStepper) {
        let currentValue = Int(sender.value)
        orderCountLabel.text = "\(currentValue)"
        updateDetailTotalPriceLabel()
        
        if currentValue == Int(stepper.maximumValue) {
            showAlert()
        }
        
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Dikkat!", message: "En fazla 10 adet secebilirsiniz", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func favButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addToCartButtonTapped(_ sender: Any) {
        guard let selectedFood else { return }
        if Int(orderCountLabel.text ?? "0") ?? 0 > 0 {
            indicator.startAnimating()
            let food = CartFoodRequest(
                yemekAdi: selectedFood.yemekAdi,
                yemekResimAdi: selectedFood.yemekResimAdi,
                yemekFiyat: selectedFood.yemekFiyat,
                yemekSiparisAdet: orderCountLabel.text ?? "",
                kullaniciAdi: "emre_yesilyurt"
            )
            viewModel?.addToCart(food: food)
        } else {
            showErrorAlert(message: "Sepete en az bir tane ürün eklemelisiniz!") {
                
            }
        }
    }
}

extension FoodDetailVC: FoodDetailViewModelDelegate {
    func imageLoaded() {
        detailImageView.image = viewModel?.foodDetailImage
        indicator.stopAnimating()
    }
    
    func imageLoadFailed(error: Error) {
        showErrorAlert(message: error.localizedDescription) { [weak self] in
            self?.indicator.stopAnimating()
        }
    }
    
    func foodsAdded() {
        showSuccessAlert(title: "Tebrikler", message: "Ürün sepete eklendi") { [weak self] in
            self?.indicator.stopAnimating()
            self?.dismiss(animated: true)
        }
    }
    
    func foodsAddedFailed(error: Error) {
        showErrorAlert(message: error.localizedDescription) { [weak self] in
            self?.indicator.stopAnimating()
        }
    }
    
}
