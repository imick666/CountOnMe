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

    override func setUp() {
        super.setUp()
        countOnMe = CountOnMe()
    }

    func testGivenFirstElementIs3withfunc_WhenSub3withfunc_ThenResultIs0() {
        countOnMe.addNumber("3")

        countOnMe.addOperator(" - ")
        countOnMe.addNumber("3")

        countOnMe.buttonEqualTaped()
        XCTAssertEqual(countOnMe.elements.last, "0.0")
    }

    func testGivenFirstElementIs3WithcFunc_WhenAdd3WithFuncAndAdd0WithFunc_ThenResultIs33() {
        countOnMe.addNumber("3")

        countOnMe.addNumber("3")
        countOnMe.addOperator(" + ")
        countOnMe.addNumber("0")

        countOnMe.buttonEqualTaped()
        XCTAssertEqual(countOnMe.elements.last, "33.0")
    }

    func testGivenFirstElementIs3_WhenMultiplyBy3_ThenResultIs9() {
        countOnMe.addNumber("3")

        countOnMe.addOperator(" x ")
        countOnMe.addNumber("3")

        countOnMe.buttonEqualTaped()
        XCTAssertEqual(countOnMe.elements.last, "9.0")
    }

    func testGivenFirstElementIs9_WhenDiviseBy3_ThenResultIs3() {
        countOnMe.addNumber("9")

        countOnMe.addOperator(" / ")
        countOnMe.addNumber("3")

        countOnMe.buttonEqualTaped()
        XCTAssertEqual(countOnMe.elements.last, "3.0")
    }

    func testGivenFirstElementIs10_WhenDiviseBy3_ThenResultIs3Dot33() {
        countOnMe.addNumber("10")

        countOnMe.addOperator(" / ")
        countOnMe.addNumber("3")

        countOnMe.buttonEqualTaped()
        XCTAssertEqual(countOnMe.elements.last, "3.33")
    }

    func testGivenFirstElementIs10_WhenDiviseBy3_ThenResultIs3Dot33AndResetPressedEqualNil() {
        countOnMe.addNumber("10")

        countOnMe.addOperator(" / ")
        countOnMe.addNumber("3")
        countOnMe.buttonEqualTaped()
        countOnMe.resetCalcul()

        XCTAssertEqual(countOnMe.elements.last, nil)
    }

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

    func testGivenFirstElementIs10_WhenDiviseByNil_ThenErrorMessageShouldAppear() {
        countOnMe.addNumber("10")

        countOnMe.addOperator(" / ")
        countOnMe.buttonEqualTaped()

        XCTAssertNotEqual(countOnMe.errorMessage, "")
    }

    func testGivenFirstElementIs10_nothing_ThenErrorMessageShouldAppear() {
        countOnMe.addNumber("10")

        countOnMe.buttonEqualTaped()

        XCTAssertNotEqual(countOnMe.errorMessage, "")
    }
}
