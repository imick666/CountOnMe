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
    
    // Error check computed variables
    var expressionIsCorrect: Bool {
        return countOnMeModel.elements.last != "+" && countOnMeModel.elements.last != "-"
    }
    
    var expressionHaveEnoughElement: Bool {
        return countOnMeModel.elements.count >= 3
    }
    
    var canAddOperator: Bool {
        return countOnMeModel.elements.last != "+" && countOnMeModel.elements.last != "-" &&
            countOnMeModel.elements.last != "/" && countOnMeModel.elements.last != "*"
    }
    
    var expressionHaveResult: Bool {
        return textView.text.firstIndex(of: "=") != nil
    }
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //notification Listenning
        let notificationName = Notification.Name(rawValue: "CountOnMeNotification")
        NotificationCenter.default.addObserver(self, selector: #selector(notificationSelector), name: notificationName, object: nil)
    }
    
    @objc func notificationSelector() {
        textView.text.append(" = \(countOnMeModel.operation)")
        countOnMeModel.operation = ""
    }

    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        if expressionHaveResult {
            textView.text = ""
        }
        textView.text.append(numberText)
        countOnMeModel.addNumber(numberText)
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        if canAddOperator {
            textView.text.append(" + ")
            countOnMeModel.addAditionOperator()
        } else {
            AlertViewController.shared.ShowAlertController(message: "Une opérateur est déja mis !", viewController: self)
        }
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        if canAddOperator {
            textView.text.append(" - ")
            countOnMeModel.addSubstractionOperator()
        } else {
            AlertViewController.shared.ShowAlertController(message: "Un opérateur est déja mis !", viewController: self)
        }
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard expressionIsCorrect else {
            return AlertViewController.shared.ShowAlertController(message: "Entrez une expression correcte !", viewController: self)
        }

        guard expressionHaveEnoughElement else {
            return AlertViewController.shared.ShowAlertController(message: "Démarrez un nouveau calcul !", viewController: self)
        }
        
        countOnMeModel.buttonEqualTaped()
    }
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        if canAddOperator {
            textView.text.append(" / ")
            countOnMeModel.addDivisionOperator()
        } else {
            AlertViewController.shared.ShowAlertController(message: "Un opérateur est déja mis !", viewController: self)
        }
    }
    
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        if canAddOperator {
            textView.text.append(" x ")
            countOnMeModel.addMultiplicationOperator()
        } else {
            AlertViewController.shared.ShowAlertController(message: "Un opérateur est déja mis !", viewController: self)
        }
    }
}

