//
//  TestAddingToFavorites.swift
//  RickAndMortyUITests
//
//  Created by Gabriel Augusto Marson on 02/05/21.
//  Copyright © 2021 Gabriel Augusto Marson. All rights reserved.
//

import XCTest
import Swifter

class SimpleRoutines: BaseXCTestCase {

    private func prepareAndLaunch() -> XCTestExpectation {
        let expectation = XCTestExpectation(description: "All Service calls were made")
        var requestCount = 1
        server["character/?page=1"] = { _ in
            guard requestCount == 1 else { return .tooManyRequests }
            expectation.fulfill()
            requestCount += 1
            return .ok(.data(JSONHandler.fileToData(file: "FirstPage")))
        }
        
        super.launch(expectation: expectation)
        
        return expectation
    }
    
    func testAdditionOfElement() throws {
        
        let expectation = prepareAndLaunch()
        routines.tapInNthPositionOfCell(0)
        routines.addToFavorites()
        wait(for: [expectation], timeout: defaultTimeout)
        XCTAssertTrue(app.buttons["Remove from favorites"].exists)
    }
    
    func testIfElementAppearsOnSavedScreenAfterItWasAdded() throws {
        let expectation = prepareAndLaunch()
        routines.tapInNthPositionOfCell(2)
        routines.addToFavorites()
        routines.swipeDown()
        routines.goToSavedCharacters()
        routines.tapInNthPositionOfCell(0)
        
        wait(for: [expectation], timeout: defaultTimeout)
        XCTAssertTrue(app.buttons["Remove from favorites"].exists)
        XCTAssertTrue(app.staticTexts["Summer Smith"].exists)
    }
    
    func testIfThereIsNoElementSavedAfterAddingAndDeletingIt() {
        let expectation = prepareAndLaunch()
        routines.tapInNthPositionOfCell(0)
        routines.addToFavorites()
        routines.removeFromFavorites()
        routines.swipeDown()
        routines.goToSavedCharacters()
        
        wait(for: [expectation], timeout: defaultTimeout)
        XCTAssertTrue(app.staticTexts["Nothing here yet"].exists)
    }

}
