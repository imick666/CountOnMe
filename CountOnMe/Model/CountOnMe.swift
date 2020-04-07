//
//  SimpleCalc.swift
//  CountOnMe
//
//  Created by mickael ruzel on 03/04/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation
class CountOnMe{
    var operation = ""
    
    var elements: [String] {
        return operation.split(separator: " ").map { "\($0)" }
    }
    
    func buttonEqualTaped() {
        makeFinalOperation()
    }
    
    func addAditionOperator() {
        operation.append(" + ")
    }
    
    func addSubstractionOperator() {
        operation.append(" - ")
    }
    
    func addMultiplicationOperator() {
        operation.append(" * ")
    }
    
    func addDivisionOperator() {
        operation.append(" / ")
    }
    
    func addNumber(_ number: String){
        operation.append(number)
    }
    
    private func makeFinalOperation() {
        var finalResult = elements

        while finalResult.count > 1 {
           guard let left = Int(finalResult[0]) else { return }
           let operand = finalResult[1]
           guard let right = Int(finalResult[2]) else { return }
           
           let result: Int
           switch operand {
           case "+": result = left + right
           case "-": result = left - right
           case "/": result = left / right
           case "*": result = left * right
           default: fatalError("Unknown operator !")
           }
           
           finalResult = Array(finalResult.dropFirst(3))
           finalResult.insert("\(result)", at: 0)
        }
        operation = finalResult.first!
    }
}
