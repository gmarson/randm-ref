//
//  ComplexRoutines.swift
//  RickAndMortyUITests
//
//  Created by Laura Pinheiro Marson on 03/05/21.
//  Copyright © 2021 Gabriel Augusto Marson. All rights reserved.
//

import XCTest

class ComplexRoutines: BaseXCTestCase {

    func testAddingAndDeletingMultipleEntries() throws {
        routines.tapInNthPositionOfCell(0)
        routines.addToFavorites()
        routines.swipeDown()
        
        routines.tapInNthPositionOfCell(3)
        routines.addToFavorites()
        routines.swipeDown()
        
        routines.goToSavedCharacters()
        routines.tapInNthPositionOfCell(0)
        routines.removeFromFavorites()
        routines.swipeDown()
        
        routines.goToDisplayingCharacters()
        app.swipeUp()
        app.swipeUp()
        sleep(2)
        routines.tapInNthPositionOfCell(19)
        routines.addToFavorites()
        routines.swipeDown()
        
        routines.goToSavedCharacters()
        XCTAssertFalse(app.staticTexts["Rick Sanchez"].exists)
        XCTAssertTrue(app.staticTexts["Beth Smith"].exists)
        XCTAssertTrue(app.staticTexts["Ants in my Eyes Johnson"].exists)
        
    }

}
