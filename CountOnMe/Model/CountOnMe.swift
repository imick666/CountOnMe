//
//  SimpleCalc.swift
//  CountOnMe
//
//  Created by mickael ruzel on 03/04/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//
//swiftlint:disable line_length
import Foundation
extension NSNotification.Name {
    static let currentCalcul = Notification.Name("currentCalcul")
    static let errorMessage = Notification.Name("errorMessage")
}

extension Double {
    func roundedWithTowDecimal() -> Double {
        return ((self * 100).rounded() / 100)
    }
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
        return elements.contains("=")
    }

    private var calculIsNull: Bool {
        return operation == "0"
    }

    // MARK: - Methodes

    func buttonEqualTaped() {
        if !expressionIsCorrect {
            errorMessage = "Entrez une expression correcte !"
            resetCalcul()
        } else if !expressionHaveEnoughElement {
            errorMessage = "Démarrez un nouveau calcul !"
            resetCalcul()
        }
        pickUpOperationElements()
    }

    func resetCalcul() {
        operation = "0"
    }

    func addOperator(_ operatorToAdd: String) {
        guard operation != "0" else { return }
        checkIfOperatorCanBeAdd {
            operation.append(" " + operatorToAdd + " ")
        }
    }

    func addNumber(_ number: String) {
        if expressionHaveResult || calculIsNull && number != "." {
            operation = ""
        }
        if elements.last == "/" && number == "0" {
            errorMessage = "Vous ne pouvez pas diviser par 0"
            resetCalcul()
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
    private func pickUpOperationElements() {
        var finalResult = elements

        //multiplication and division priority
        while finalResult.contains("x") || finalResult.contains("/") {
            guard let index = finalResult.firstIndex(where: { $0 == "x" || $0 == "/" }) else { return } //Que veut dire "$0"???!!!

            guard let left = Double(finalResult[index - 1]) else { return }
            let operand = finalResult[index]
            guard let right = Double(finalResult[index + 1]) else { return }

            let result = calculate(left, operand, right)

            finalResult[index] = "\(result.roundedWithTowDecimal())"
            finalResult.remove(at: index + 1)
            finalResult.remove(at: index - 1)
        }

        //calcule the reste
        while finalResult.count > 1 {
            guard let left = Double(finalResult[0]) else { return }
            let operand = finalResult[1]
            guard let right = Double(finalResult[2]) else { return }

            let result = calculate(left, operand, right)

            finalResult = Array(finalResult.dropFirst(3))
            finalResult.insert("\(result.roundedWithTowDecimal())", at: 0)
        }
        operation.append(" = \(finalResult.first!) ")
    }

    private func calculate(_ left: Double, _ operand: String, _ right: Double) -> Double {
        switch operand {
        case "+": return left + right
        case "-": return left - right
        case "/": return left / right
        case "x": return left * right
        default: fatalError("Unknown operator !")
        }
    }
}
