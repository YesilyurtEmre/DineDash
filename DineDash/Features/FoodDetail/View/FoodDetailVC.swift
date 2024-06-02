//
//  ProductDetailVC.swift
//  DineDash
//
//  Created by Emre Yeşilyurt on 29.05.2024.
//

import UIKit

final class FoodDetailVC: UIViewController {
    
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var detailTotalPriceLabel: UILabel!
    @IBOutlet weak var productNumberLabel: UILabel!
    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var detailPriceLabel: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    
    let pricePerProduct = 10.0
    
    var selectedItem: Any?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateProductNumberLabel()
        updateDetailTotalPriceLabel()
        stepper.addTarget(self, action: #selector(stepperValueChanged), for: .valueChanged)
        
    }
    
    func updateDetailTotalPriceLabel() {
        let totalPrice = pricePerProduct * stepper.value
        
      detailTotalPriceLabel.text = String("₺\(Int(totalPrice))")
    }
    
    @objc func stepperValueChanged() {
        updateProductNumberLabel()
        updateDetailTotalPriceLabel()
    }
    
    func updateProductNumberLabel() {
        productNumberLabel.text = "Ürün Adet: \(Int(stepper.value))"
    }
    
    @IBAction func stepperChange(_ sender: UIStepper) {
        let currentValue = Int(sender.value)
        productNumberLabel.text = "Ürün Adet: \(currentValue)"
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
        
    }
}
