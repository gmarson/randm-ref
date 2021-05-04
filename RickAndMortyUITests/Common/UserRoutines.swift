//
//  UserRoutines.swift
//  RickAndMortyUITests
//
//  Created by Gabriel Augusto Marson on 02/05/21.
//  Copyright © 2021 Gabriel Augusto Marson. All rights reserved.
//

import Foundation
import XCTest

class UserRoutines {
    
    private let app: XCUIApplication
    
    init(_ app: XCUIApplication) {
        self.app = app
    }
    
    func swipeDown(wait: UInt32 = 0) {
        sleep(wait)
        app.swipeDown(velocity: .fast)
    }
    
    func tapInNthPositionOfCell(_ n : Int, wait: TimeInterval = 0) {
        let table = app.tables.element(boundBy: 0)
        let cellAt = table.cells.element(boundBy: n)
        
        guard cellAt.waitForExistence(timeout: wait) else {
            XCTFail("cell not found")
            return
        }
        
        cellAt.tap()
    }
    
    func tapButton(_ name: String, wait: TimeInterval = 0) {
        
        let button = app.buttons[name]
        
        guard button.waitForExistence(timeout: wait) else {
            XCTFail("button not found")
            return
        }
        
        button.tap()
    }
    
    func addToFavorites(wait: TimeInterval = 0) {
        tapButton("Add to favorites", wait: wait)
    }
    
    func removeFromFavorites(wait: TimeInterval = 0) {
        tapButton("Remove from favorites", wait: wait)
    }
    
    func goToSavedCharacters() {
        app.tabBars.buttons.element(boundBy: 1).tap()
    }
    
    func goToDisplayingCharacters() {
        app.tabBars.buttons.element(boundBy: 0).tap()
    }
    
}
