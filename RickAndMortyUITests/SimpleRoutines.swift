//
//  TestAddingToFavorites.swift
//  RickAndMortyUITests
//
//  Created by Laura Pinheiro Marson on 02/05/21.
//  Copyright © 2021 Gabriel Augusto Marson. All rights reserved.
//

import XCTest

class SimpleRoutines: BaseXCTestCase {

    func testAdditionOfElement() throws {
        routines.tapInNthPositionOfCell(0)
        routines.addToFavorites()
        XCTAssertTrue(app.buttons["Remove from favorites"].exists)
    }
    
    func testIfElementAppearsOnSavedScreenAfterItWasAdded() throws {
        routines.tapInNthPositionOfCell(2)
        routines.addToFavorites()
        routines.swipeDown()
        routines.goToSavedCharacters()
        routines.tapInNthPositionOfCell(0)
        XCTAssertTrue(app.buttons["Remove from favorites"].exists)
        XCTAssertTrue(app.staticTexts["Summer Smith"].exists)
    }
    
    func testIfThereIsNoElementSavedAfterAddingAndDeletingIt() {
        routines.tapInNthPositionOfCell(0)
        routines.addToFavorites()
        routines.removeFromFavorites()
        routines.swipeDown()
        routines.goToSavedCharacters()
        XCTAssertTrue(app.staticTexts["Nothing here yet"].exists)
    }

}
