//
//  FastlaneSnapshot.swift
//  FastlaneSnapshot
//
//  Created by Mickael Ruzel on 06/01/2022.
//  Copyright © 2022 Vincent Saluzzo. All rights reserved.
//

import XCTest

class FastlaneSnapshot: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        
        XCUIDevice.shared.orientation = .portrait
    }
    
    override func tearDown() {
        super.tearDown()
        app = nil
    }
    
    func testOnePlusTwoEqualThree() {
        
        app.buttons["1"].tap()
        app.buttons["+"].tap()
        app.buttons["2"].tap()
        
        snapshot("1")
        
        app.buttons["="].tap()
        
        snapshot("2")
                
    }
    
    func testDevideByZero() {
        
        app.buttons["2"].tap()
        app.buttons["÷"].tap()
        app.buttons["0"].tap()
        
        snapshot("3")
    }
    
    func testLandscape() {
        
        XCUIDevice.shared.orientation = .landscapeLeft
        
        app.buttons["1"].tap()
        app.buttons["0"].tap()
        app.buttons["+"].tap()
        app.buttons["5"].tap()
        
        app.buttons["="].tap()
        snapshot("4")
        
    }
}
