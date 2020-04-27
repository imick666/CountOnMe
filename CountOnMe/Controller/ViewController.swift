//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Outlets

    @IBOutlet weak var calculLabel: UILabel!
    @IBOutlet var buttonStyle: [RoundButton]!

    // MARK: - Properties

    let countOnMeModel = CountOnMe()

    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        for button in buttonStyle {
            button.setUpButton()
        }
        // Do any additional setup after loading the view.
        receiveNotification(.currentCalcul)
        receiveNotification(.errorMessage)
    }

    // MARK: - Notifications Selectors
    @objc func currentCalcul() {
        var currentCalcul: String {
            return countOnMeModel.operation
        }
        calculLabel.text = currentCalcul
    }

    @objc func errorMessage() {
        var errorMessage: String {
            return countOnMeModel.errorMessage
        }
        AlertViewController.shared.showAlertController(message: errorMessage, viewController: self)
    }

    // MARK: - Privaet Methodes

    //crate notification
    private func receiveNotification(_ name: Notification.Name) {
        let selector = Selector((name.rawValue))
        NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
    }

    // MARK: - Actions
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else { return }
        countOnMeModel.addNumber(numberText)
    }

    @IBAction func tappedOperatorButton(_ sender: UIButton) {
        guard let operatorText = sender.title(for: .normal) else { return }
        countOnMeModel.addOperator(operatorText)
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        countOnMeModel.buttonEqualTaped()
    }

    @IBAction func resetButtonPressed() {
        countOnMeModel.resetCalcul()
    }
}
