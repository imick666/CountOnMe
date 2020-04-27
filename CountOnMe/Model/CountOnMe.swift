//
//  SimpleCalc.swift
//  CountOnMe
//
//  Created by mickael ruzel on 03/04/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation
extension NSNotification.Name {
    static let currentCalcul = Notification.Name("currentCalcul")
    static let errorMessage = Notification.Name("errorMessage")
}

class CountOnMe {
    // MARK: - Properties
    var operation = "" {
        didSet {
            sendNotification(.currentCalcul)
        }
    }

    var errorMessage = "" {
        didSet {
            sendNotification(.errorMessage)
        }
    }

    //convert operation in array
    var elements: [String] {
        return operation.split(separator: " ").map { "\($0)" }
    }

    // Error check computed variables
    private var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-"
            && elements.last != "/" && elements.last != "x"
    }

    private var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }

    private var expressionHaveResult: Bool {
        return elements.firstIndex(of: "=") != nil
    }

    // MARK: - Methodes
    func buttonEqualTaped() {
        guard expressionIsCorrect else {
            errorMessage = "Entrez une expression correcte !"
            return
        }
        guard expressionHaveEnoughElement else {
            errorMessage = "Démarrez un nouveau calcul !"
            return
        }
        makeFinalOperation()
    }

    func resetCalcul() {
        operation = ""
    }

    func addOperator(_ operatorToAdd: String) {
        checkIfOperatorCanBeAdd {
            operation.append(" " + operatorToAdd + " ")
        }
    }

    func addNumber(_ number: String) {
        if expressionHaveResult {
            resetCalcul()
        }
        if elements.last == "/" && number == "0" {
            errorMessage = "Vous ne pouvez pas diviser par 0"
            return
        }
        operation.append(number)
    }

    // MARK: - Private Methodes
    //create norification sender
    private func sendNotification(_ name: Notification.Name) {
        let notification = Notification(name: name)
        NotificationCenter.default.post(notification)
    }

    // check if an operartor can be add
    private func checkIfOperatorCanBeAdd(_ closure: () -> Void) {
        if expressionIsCorrect {
            if expressionHaveResult {
                operation = elements.last!
            }
            closure()
        } else {
            errorMessage = "Un opérateur est déja mis !"
        }
    }

    //make operation when "=" pressed
    private func makeFinalOperation() {
        var finalResult = elements

        while finalResult.count > 1 {
            guard let left = Double(finalResult[0]) else { return }
            let operand = finalResult[1]
            guard let right = Double(finalResult[2]) else { return }

            let result: Double
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "/": result = left / right
            case "x": result = left * right
            case "=": return
            default: fatalError("Unknown operator !")
            }

            finalResult = Array(finalResult.dropFirst(3))
            finalResult.insert("\((result * 100).rounded() / 100)", at: 0)
        }
        operation.append(" = \(finalResult.first!) ")
    }
}
