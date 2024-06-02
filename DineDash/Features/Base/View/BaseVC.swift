//
//  BaseVC.swift
//  DineDash
//
//  Created by Emre Yeşilyurt on 2.06.2024.
//

import UIKit
import MaterialActivityIndicator
import SwiftAlertView

class BaseVC: UIViewController {
    let indicator = MaterialActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureActivityIndicatorView()
    }
    
    private func configureActivityIndicatorView() {
        view.addSubview(indicator)
        configureActivityIndicatorViewConstraints()
    }
    
    private func configureActivityIndicatorViewConstraints() {
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func showErrorAlert(message: String, completion: @escaping () -> Void ) {
        SwiftAlertView.show(title: "Error", message: message, buttonTitles: ["Ok"]).onButtonClicked { _, _ in
            completion()
        }
    }
}
