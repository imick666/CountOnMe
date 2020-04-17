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
        receiveNotification(.currentCalcul)
        receiveNotification(.errorMessage)
    }

    // MARK: - Notification Selectors
    @objc func currentCalcul() {
        var currentCalcul: String {
            return countOnMeModel.operation
        }
        textView.text = currentCalcul
    }

    @objc func errorMessage() {
        var errorMessage: String {
            return countOnMeModel.errorMessage
        }
        AlertViewController.shared.showAlertController(message: errorMessage, viewController: self)
    }

    //crate notification
    private func receiveNotification(_ name: Notification.Name) {
        let selector = Selector((name.rawValue))
        NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
    }

    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        countOnMeModel.addNumber(numberText)
    }

    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        countOnMeModel.addOperator(" + ")
    }

    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        countOnMeModel.addOperator(" - ")
    }

    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        countOnMeModel.addOperator(" / ")
    }

    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        countOnMeModel.addOperator(" x ")
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        countOnMeModel.buttonEqualTaped()
    }
}
