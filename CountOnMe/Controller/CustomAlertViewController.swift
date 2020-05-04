//
//  AlertViewController.swift
//  CountOnMe
//
//  Created by mickael ruzel on 07/04/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import UIKit

class CustomAlertViewController {

    static let shared = CustomAlertViewController()
    private init() {}

    func showAlertController (message: String, viewController: UIViewController) {
        let alertVC = UIAlertController(title: "Zéro!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        viewController.present(alertVC, animated: true, completion: nil)
    }
}
