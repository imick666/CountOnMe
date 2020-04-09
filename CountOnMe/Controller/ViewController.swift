//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    let countOnMeModel = CountOnMe()
    
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        receiveNotification("currentCalcul")
        receiveNotification("alertOperator")
        receiveNotification("alertExpression")
        receiveNotification("alertNewCalcul")
    }
    
    // MARK: - Notification Selectors
    @objc func alertNewCalcul() {
        AlertViewController.shared.ShowAlertController(message: "Démarrez un nouveau calcul !", viewController: self)
    }
    
    @objc func alertExpression() {
        AlertViewController.shared.ShowAlertController(message: "Entrez une expression correcte !", viewController: self)
    }
    
    @objc func currentCalcul() {
        textView.text = countOnMeModel.operation
    }
    
    @objc func alertOperator() {
        AlertViewController.shared.ShowAlertController(message: "Une opérateur est déja mis !", viewController: self)
    }
    
    //crate notification
    private func receiveNotification(_ name: String) {
        let notificationName = Notification.Name(name)
        let selector = Selector((name))
        NotificationCenter.default.addObserver(self, selector: selector, name: notificationName, object: nil)
    }
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        countOnMeModel.addNumber(numberText)
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        countOnMeModel.addAditionOperator()
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        countOnMeModel.addSubstractionOperator()
    }

    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        countOnMeModel.addDivisionOperator()
    }
    
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        countOnMeModel.addMultiplicationOperator()
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        countOnMeModel.buttonEqualTaped()
    }
}

