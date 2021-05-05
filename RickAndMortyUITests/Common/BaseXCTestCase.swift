//
//  BaseXCTestCase.swift
//  RickAndMortyUITests
//
//  Created by Gabriel Augusto Marson on 02/05/21.
//  Copyright © 2021 Gabriel Augusto Marson. All rights reserved.
//

import Foundation
import XCTest
import Swifter

class BaseXCTestCase: XCTestCase {

    private enum UITestAproaches: String {
        case localHost
        case realServer
    }
    
    let app = XCUIApplication()
    let server = HttpServer()
    private let approach: UITestAproaches = .localHost
    
    lazy var routines: UserRoutines = .init(app)
    lazy var identifiers: Identifiers = .init()
    
    let requestErrorMessage = "Sent more requests than it should"
    let defaultTimeout: TimeInterval = 10
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        try server.start(8080, forceIPv4: true, priority: .default)
        app.launchArguments = ["uitest", approach.rawValue]
    }

    override func tearDownWithError() throws {
        server.stop()
        try super.tearDownWithError()
    }
    
    func launch(expectation: XCTestExpectation) {
        if approach == .realServer { expectation.fulfill() }
        app.launch()
    }

}
