//
//  FavoritesVC.swift
//  DineDash
//
//  Created by Emre Yeşilyurt on 26.05.2024.
//

import UIKit

final class FavoritesVC: BaseVC {
    @IBOutlet weak var tableView: UITableView!
    private var favoriteFoods: [FavoriteFoods] = []
    private var emptyView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        loadFavoriteFoods()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadFavoriteFoods()
    }
    
    private func loadFavoriteFoods() {
        favoriteFoods = FavoritesFoodManager.shared.getFoods()
        tableView.reloadData()
        updateEmptyView()
    }
    
    private func updateEmptyView() {
        if favoriteFoods.isEmpty {
            createEmptyView()
        } else {
            emptyView?.removeFromSuperview()
        }
    }
    
    private func createEmptyView() {
        emptyView?.removeFromSuperview()
        
        let emptyView = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
        emptyView.center = self.view.center
        
        let imageView = UIImageView(image: UIImage(systemName: "heart.fill"))
        imageView.tintColor = .lightGray
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = "Favori ürün bulunmamakta"
        label.textAlignment = .center
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        emptyView.addSubview(imageView)
        emptyView.addSubview(label)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -20),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            label.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor)
        ])
        
        self.view.addSubview(emptyView)
        self.emptyView = emptyView
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate   = self
        tableView.register(UINib(nibName: "FavoriteCell", bundle: nil), forCellReuseIdentifier: "FavoriteCell")
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    private func createEmptyFavoriteView() {
        
    }
}

extension FavoritesVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoriteFoods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell") as? FavoriteCell else { return UITableViewCell() }
        let food = favoriteFoods[indexPath.row]
        cell.foodNameLabel.text = food.name
        cell.foodPriceLabel.text = (food.price ?? "") + " ₺"
        if let imageData = food.image {
            cell.foodImageView.image = UIImage(data: imageData)
        }
        cell.foodId = food.foodId
        cell.delegate = self
        cell.indexPath = indexPath
        cell.favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

extension FavoritesVC: FavoriteCellDelegate {
    
    func didTapFavoriteButton(foodId: Int32) {
        FavoritesFoodManager.shared.deleteFood(foodId: foodId)
        loadFavoriteFoods()
    }
    
    
}
