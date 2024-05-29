//
//  HomeVC.swift
//  DineDash
//
//  Created by Emre Yeşilyurt on 26.05.2024.
//

import UIKit

final class HomeVC: UIViewController {
 
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var viewModel = HomeViewModel()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCollectionView()
        prepareSearchBar()
        viewModel.fetchProducts()
        
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
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCell
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as? ProductCell, let product = viewModel.getProduct(at: indexPath.row) else { return UICollectionViewCell() }
        
        cell.productImgView.image = UIImage(named: product.image ?? "")
        cell.nameLabel.text =  product.name
        cell.priceLabel.text = "\(product.price ?? 0) ₺"
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.3
        cell.layer.cornerRadius = 10
        
        cell.indexPath = indexPath
        
        return cell
    }
}


