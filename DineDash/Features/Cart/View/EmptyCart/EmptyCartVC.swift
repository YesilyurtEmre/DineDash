//
//  EmptyCartVC.swift
//  DineDash
//
//  Created by Emre Yeşilyurt on 1.06.2024.
//

import UIKit

final class EmptyCartVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func startShoppingButtonTapped(_ sender: Any) {
        if let tabBarController = self.tabBarController {
            tabBarController.selectedIndex = 0 // Home tab indexini belirtin, genelde ilk tab 0 indeksindedir
        }
    }
}
