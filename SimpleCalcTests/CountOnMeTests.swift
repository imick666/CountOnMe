//
//  SimpleCalcTests.swift
//  SimpleCalcTests
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CountOnMeTests: XCTestCase {
    var countOnMe: CountOnMe!

    // MARK: - Operations Test

    override func setUp() {
        super.setUp()
        countOnMe = CountOnMe()
    }

    func testGiven2Dot_WhenAddDot_ThenNothingShouldBeAdd() {
        countOnMe.addNumber("2")
        countOnMe.addNumber(".")

        countOnMe.addNumber(".")

        XCTAssertEqual(countOnMe.elements.last!, "2.")
    }

    func testGiven3_WhenSub3_ThenResultIs0() {
        countOnMe.addNumber("3")

        countOnMe.addOperator("-")
        countOnMe.addNumber("3")

        countOnMe.buttonEqualTaped()
        XCTAssertEqual(countOnMe.elements.last, "0.0")
    }

    func testGiven3And3_WhenAdd0_ThenResultIs33() {
        countOnMe.addNumber("3")
        countOnMe.addNumber("3")

        countOnMe.addOperator("+")
        countOnMe.addNumber("0")

        countOnMe.buttonEqualTaped()
        XCTAssertEqual(countOnMe.elements.last, "33.0")
    }

    func testGiven3_WhenMultiplyBy3_ThenResultIs9() {
        countOnMe.addNumber("3")

        countOnMe.addOperator("x")
        countOnMe.addNumber("3")

        countOnMe.buttonEqualTaped()
        XCTAssertEqual(countOnMe.elements.last, "9.0")
    }

    func testGiven10_WhenDividedBy3_ThenResultIs3Dot33() {
        countOnMe.addNumber("10")

        countOnMe.addOperator("÷")
        countOnMe.addNumber("3")

        countOnMe.buttonEqualTaped()
        XCTAssertEqual(countOnMe.elements.last, "3.33")
    }

    func testGiven10divedBy3_WhenResertButtonPressed_ThenResultIs0() {
        countOnMe.addNumber("10")

        countOnMe.addOperator("÷")
        countOnMe.addNumber("3")
        countOnMe.buttonEqualTaped()
        countOnMe.resetCalcul()

        XCTAssertEqual(countOnMe.elements.last, "0")
    }

    func testGiven2Plus2Equal4_WhenPressedButtonNumber2_ThenOperationIs2() {
        countOnMe.addNumber("2")
        countOnMe.addOperator("+")
        countOnMe.addNumber("2")
        countOnMe.buttonEqualTaped()

        countOnMe.addNumber("2")

        XCTAssertEqual(countOnMe.operation, "2")
    }

    func testGivenFirstElementIs2Dot5_WhenMultiplyBy2_ThenResultIs5() {
        countOnMe.addNumber("2.5")

        countOnMe.addOperator("x")
        countOnMe.addNumber("2")

        countOnMe.buttonEqualTaped()
        XCTAssertEqual(countOnMe.elements.last, "5.0")
    }

    func testGiven2Plus3_WhenMultiplyBy3Plus2_ThenResultIs13() {
        countOnMe.addNumber("2")
        countOnMe.addOperator(" + ")
        countOnMe.addNumber("3")

        countOnMe.addOperator(" x ")
        countOnMe.addNumber("3")
        countOnMe.addOperator("+")
        countOnMe.addNumber("2")

        countOnMe.buttonEqualTaped()
        XCTAssertEqual(countOnMe.elements.last, "13.0")
    }

    func testGiven2Plus3MultiplyBy3_WhenDevidedBy2_ThenResultIs6Dot5() {
        countOnMe.addNumber("2")
        countOnMe.addOperator("+")
        countOnMe.addNumber("3")

        countOnMe.addOperator("x")
        countOnMe.addNumber("3")
        countOnMe.addOperator("÷")
        countOnMe.addNumber("2")

        countOnMe.buttonEqualTaped()
        XCTAssertEqual(countOnMe.elements.last, "6.5")
    }

    func testGiven2Plus2Equal4_WhenDevided_ThenOperationShoulBe4devide() {
        countOnMe.addNumber("2")
        countOnMe.addOperator("+")
        countOnMe.addNumber("2")
        countOnMe.buttonEqualTaped()

        countOnMe.addOperator("÷")

        XCTAssertEqual(countOnMe.operation, "4.0 ÷ ")
    }

    func testGivenNothing_WhenTypingDotAnd2_ThenOperationShoulBe0Dot2() {

        countOnMe.addNumber(".")
        countOnMe.addNumber("2")

        XCTAssertEqual(countOnMe.operation, "0.2")
    }
    // MARK: - Notification Test

    func testNotificationWhenOperationModified() {
        expectation(forNotification: .currentCalcul, object: nil, handler: nil)

        countOnMe.addNumber("9")

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testNotificationWhenErrorMessage() {
        expectation(forNotification: .errorMessage, object: nil, handler: nil)

        countOnMe.errorMessage = "ceci est une erreur"

        waitForExpectations(timeout: 5, handler: nil)
    }

    // MARK: - Error Test

    func testGivenFirstElementIs10_WhenDiviseByNil_ThenErrorMessageShouldAppear() {
        countOnMe.addNumber("10")

        countOnMe.addOperator("÷")
        countOnMe.buttonEqualTaped()

        XCTAssertNotEqual(countOnMe.errorMessage, "")
    }

    func testGivenFirstElementIs10_nothing_ThenErrorMessageShouldAppear() {
        countOnMe.addNumber("10")

        countOnMe.buttonEqualTaped()

        XCTAssertNotEqual(countOnMe.errorMessage, "")
    }

    func testGiven10Divided_WhenAddDivideSign_ThenErrorMessageShouldAppear() {
        countOnMe.addNumber("10")
        countOnMe.addOperator("÷")

        countOnMe.addOperator("÷")

        XCTAssertNotEqual(countOnMe.errorMessage, "")
    }

    func testGiven10Divided_WhenAdd0_ThenErrorMessageShouldAppear() {
        countOnMe.addNumber("10")
        countOnMe.addOperator("÷")

        countOnMe.addNumber("0")

        XCTAssertNotEqual(countOnMe.errorMessage, "")
    }
}
