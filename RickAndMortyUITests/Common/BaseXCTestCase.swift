//
//  BaseXCTestCase.swift
//  RickAndMortyUITests
//
//  Created by Laura Pinheiro Marson on 02/05/21.
//  Copyright © 2021 Gabriel Augusto Marson. All rights reserved.
//

import XCTest

class BaseXCTestCase: XCTestCase {

    let app = XCUIApplication()
    
    lazy var routines: UserRoutines = .init(app)
    lazy var identifiers: Identifiers = .init()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app.launchArguments = ["enable-testing"]
        app.launch()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

}
