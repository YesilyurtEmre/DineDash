//
//  CartVC.swift
//  DineDash
//
//  Created by Emre Yeşilyurt on 26.05.2024.
//

import UIKit

final class CartVC: UIViewController {
    
    @IBOutlet weak var cartTotalPrice: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTotalPrice()
        configureTableView()
    }
    
    private func configureTotalPrice() {
        let totalCost = CartProductMockData.products.reduce(0.0) { (result, product) in
            result + Double((product.yemekFiyat * product.yemekSiparisAdet))
        }
        cartTotalPrice.text = "\(totalCost)"
    }
    
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CartCell", bundle: nil), forCellReuseIdentifier: "CartCell")
    }
    
    @IBAction func cartCloseButtonTapped(_ sender: UIButton) {
    }
    
    
    @IBAction func confirmButtonTapped(_ sender: Any) {
    }
}

extension CartVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CartProductMockData.products.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as? CartCell else {
            return UITableViewCell()
        }
        let model = CartProductMockData.products[indexPath.row]
        cell.configure(product: model)
        return cell
    }
    
    
}
