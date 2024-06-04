//
//  FavoritesVC.swift
//  DineDash
//
//  Created by Emre Yeşilyurt on 26.05.2024.
//

import UIKit

final class FavoritesVC: BaseVC {
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = FavoriteFoodListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        //indicator.startAnimating()
        viewModel.delegate? = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getFoods()
    }
    
    private func getFoods() {
        //indicator.startAnimating()
        viewModel.fetchFoods { isSuccess, errorMessage in
            if !isSuccess {
                guard let errorMessage = errorMessage else { return }
                self.showErrorAlert(message: errorMessage) {
                    self.indicator.stopAnimating()
                }
            }
        }
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate   = self
        tableView.register(UINib(nibName: "FavoriteCell", bundle: nil), forCellReuseIdentifier: "FavoriteCell")
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
}

extension FavoritesVC: FavoriteFoodListViewModelDelegate {
    func foodsLoaded() {
        indicator.stopAnimating()
        tableView.reloadData()
    }
    
    func foodsFailed(error: Error) {
        showErrorAlert(message: "Hata Alındı") {
            self.indicator.stopAnimating()
        }
    }
    
    
}

extension FavoritesVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getFoodCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell") as? FavoriteCell else { return UITableViewCell() }
        cell.foodNameLabel.text = viewModel.getFood(at: indexPath.row)?.name
        cell.foodPriceLabel.text = viewModel.getFood(at: indexPath.row)?.price
        if let imageData = viewModel.getFood(at: indexPath.row)?.image as? Data {
            cell.foodImageView.image = UIImage(data: imageData)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "FoodDetailView", bundle: nil)
        if let foodDetailVC = storyboard.instantiateViewController(withIdentifier: "FoodDetailVC") as? FoodDetailVC {
            if let navigationController = self.navigationController {
                navigationController.pushViewController(foodDetailVC, animated: true)
            } else {
                present(foodDetailVC, animated: true, completion: nil)
            }
        } else {
            print("ViewController with identifier 'FoodDetailVC' could not be instantiated")
        }
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
