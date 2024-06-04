//
//  CartVC.swift
//  DineDash
//
//  Created by Emre Yeşilyurt on 26.05.2024.
//

import UIKit

final class CartVC: BaseVC {
    
    @IBOutlet weak var cartTotalPrice: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: CartViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CartViewModel()
        checkCartItems()
        configureTotalPrice()
        configureTableView()
        navigationController?.setNavigationBarHidden(true, animated: true)
        viewModel?.delegate = self
        
    }
    
    private func checkCartItems() {
        if ((viewModel?.cartItems.isEmpty) != nil) {
            showEmptyCart()
        }
    }
    
    
    func showEmptyCart() {
        let storyboard = UIStoryboard(name: "EmptyCartView", bundle: nil)
        if let emptyCartVC = storyboard.instantiateViewController(withIdentifier: "EmptyCartVC") as? EmptyCartVC {
            navigationController?.pushViewController(emptyCartVC, animated: true)
        }
    }
    
    private func configureTotalPrice() {

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

extension CartVC: CartViewModelDelegate {
    func getFoodToCart() {
        print("get Food Cart")
    }
    
    func getFoodToCartFailed(error: Error) {
        print("get food to cart failed")
    }
    
    
}
