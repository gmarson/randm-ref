//
//  ComplexRoutines.swift
//  RickAndMortyUITests
//
//  Created by Gabriel Augusto Marson on 03/05/21.
//  Copyright © 2021 Gabriel Augusto Marson. All rights reserved.
//

import XCTest
import Swifter

class ComplexRoutines: BaseXCTestCase {

    func testAddingAndDeletingMultipleEntries() throws {
        let expectation = XCTestExpectation(description: "All Service calls were made")
        var requestCount = 1
        
        server["character"] = { _ in
            var response: HttpResponse
            
            switch requestCount {
            case 1:
                response = .ok(.data(JSONHandler.fileToData(file: "FirstPage")))
            case 2:
                expectation.fulfill()
                response = .ok(.data(JSONHandler.fileToData(file: "SecondPage")))
            default:
                response = .tooManyRequests
            }
            
            requestCount += 1
            return response
        }
        
        super.launch(expectation: expectation)
    
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
        routines.tapInNthPositionOfCell(20)
        routines.addToFavorites()
        routines.swipeDown()
        
        routines.goToSavedCharacters()
        
        wait(for: [expectation], timeout: defaultTimeout)
        XCTAssertFalse(app.staticTexts["Rick Sanchez"].exists)
        XCTAssertTrue(app.staticTexts["Beth Smith"].exists)
        XCTAssertTrue(app.staticTexts["Aqua Morty"].exists)
        
    }

}
