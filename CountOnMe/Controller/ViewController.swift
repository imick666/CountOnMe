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

    @IBOutlet weak var calculTextView: RoundedTextView!
    @IBOutlet var buttonStyle: [RoundButton]!
    @IBOutlet weak var resetButton: RoundButton!

    // MARK: - Properties

    let countOnMeModel = CountOnMe()

    // MARK: - View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        receiveNotification(.currentCalcul)
        receiveNotification(.errorMessage)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        countOnMeModel.operation = "0"
        setupRoundedInterface()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        coordinator.animate(alongsideTransition: { (_) in
            self.setupRoundedInterface()
        })
    }
    // MARK: - Notifications Selectors

    @objc func currentCalcul() {
        var currentCalcul: String {
            let operation = countOnMeModel.operation
            let format = operation.replacingOccurrences(of: ".0", with: "")
            return format.replacingOccurrences(of: ".", with: ",")
        }
        calculTextView.text = currentCalcul

        if currentCalcul == "0" {
            resetButton.setTitle("AC", for: .normal)
        } else {
            resetButton.setTitle("C", for: .normal)
        }
    }

    @objc func errorMessage() {
        let errorMessage = countOnMeModel.errorMessage
        CustomAlertViewController.shared.showAlertController(message: errorMessage, viewController: self)
    }

    // MARK: - Privaet Methodes

    //Update rounded button Style
    private func setupRoundedInterface() {
        for button in buttonStyle {
            button.setUpButton()
        }
        calculTextView.roundedTextView()
    }

    //create notification
    private func receiveNotification(_ name: Notification.Name) {
        let selector = Selector((name.rawValue))
        NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
    }

    // MARK: - Actions
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard var numberText = sender.title(for: .normal) else { return }
        //convert "," in "."
        if numberText == "," {
            numberText = "."
        }
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
