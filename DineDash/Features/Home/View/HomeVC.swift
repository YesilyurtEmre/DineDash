//
//  HomeVC.swift
//  DineDash
//
//  Created by Emre Yeşilyurt on 26.05.2024.
//

import UIKit

protocol HomeViewControllerDelegate: AnyObject {
    func didUpdateFavorites()
}

final class HomeVC: BaseVC {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var viewModel = HomeViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCollectionView()
        prepareSearchBar()
        navigationController?.setNavigationBarHidden(true, animated: true)
        viewModel.delegate = self
        indicator.startAnimating()
        NotificationCenter.default.addObserver(self, selector: #selector(handleFavoriteButtonTapped(notification:)), name: Notification.Name("FavoriteButtonTapped"), object: nil)
    }
    
    @objc private func handleFavoriteButtonTapped(notification: Notification) {
        guard let indexPath = notification.object as? IndexPath,
              let food = viewModel.getProduct(at: indexPath.row) else { return }
        
        let isFavorite = FavoritesFoodManager.shared.isFavorite(foodId: Int32(food.yemekId) ?? 0)
        
        if isFavorite {
            FavoritesFoodManager.shared.deleteFood(foodId: Int32(food.yemekId) ?? 0)
        } else {
            let foodImage = viewModel.foodImages[food.yemekId]?.pngData()
            FavoritesFoodManager.shared.saveFood(foodId: Int32(food.yemekId) ?? 0, name: food.yemekAdi, price: food.yemekFiyat, image: foodImage ?? Data())
        }
        
        if let cell = productCollectionView.cellForItem(at: indexPath) as? FoodCell {
            cell.isFavorite = !isFavorite
        }
    }
    
    private func prepareCollectionView() {
        productCollectionView.dataSource = self
        productCollectionView.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top:10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        
        
        let screenWidth = UIScreen.main.bounds.width
        let itemWidth = (screenWidth - 30) / 2
        
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.5)
        
        productCollectionView.collectionViewLayout = layout
        productCollectionView.reloadData()
    }
    
    private func prepareSearchBar() {
        searchBar.delegate = self
        searchBar.barTintColor = .white
        searchBar.setBackgroundImage(UIImage.init(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        searchBar.placeholder = "Ara"
    }
    
    @objc private func reloadData() {
            productCollectionView.reloadData()
        }
}

extension HomeVC: HomeViewModelDelegate {
    func foodsFailed(error: Error) {
        showErrorAlert(message: error.localizedDescription) { [weak self] in
            self?.indicator.stopAnimating()
        }
    }
    
    func foodsLoaded() {
        productCollectionView.reloadData()
        indicator.stopAnimating()
    }
}

extension HomeVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchProduct(searchText: searchText)
        productCollectionView.reloadData()
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getProductCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCell", for: indexPath) as? FoodCell, let food = viewModel.getProduct(at: indexPath.row) else { return UICollectionViewCell() }
        
        cell.productImgView.image = viewModel.foodImages[food.yemekId]
        cell.nameLabel.text =  food.yemekAdi
        cell.priceLabel.text = food.yemekFiyat
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.3
        cell.layer.cornerRadius = 10
        
        cell.indexPath = indexPath
        cell.delegate = self
        cell.isFavorite = FavoritesFoodManager.shared.isFavorite(foodId: Int32(food.yemekId) ?? 0)
        cell.foodId = Int(food.yemekId)
        
        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "FoodDetailView", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(identifier: "FoodDetailVC") as? FoodDetailVC {
            detailVC.hidesBottomBarWhenPushed = true
            detailVC.selectedFood = viewModel.filteredFoods?[indexPath.item]
            navigationController?.pushViewController(detailVC, animated: true)
            
        }
    }
}

extension HomeVC: FoodCellDelegate {
    func didTapFavoriteButton(foodId: Int32) {
        productCollectionView.reloadData()
    }
    
    
}


