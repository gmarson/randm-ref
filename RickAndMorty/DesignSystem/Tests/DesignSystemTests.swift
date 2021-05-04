//
//  DesignSystemTests.swift
//  RickAndMortyTests
//
//  Created by Gabriel Augusto Marson on 05/08/20.
//  Copyright © 2020 Gabriel Augusto Marson. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import RickAndMorty

class DesignSystemTests: XCTestCase {

    func testDesignSystemFonts() throws {
        // given
        var designSystemFonts: [UIFont] = []
        
        // when
        designSystemFonts = [
            .tinyBold, .smallBold, .regularBold, .largeBold, .hugeBold,
            .tinyItalic, .smallItalic, .regularItalic, .largeItalic, .hugeItalic,
            .tiny, .small, .regular, .large, .huge
        ]
        
        // then
        assertSnapshot(matching: designSystemFonts, as: .dump)
    }
    
    func testDesignSystemPaddings() throws {
        // given
        var designSystemPaddings: [CGFloat] = []
        
        // when
        designSystemPaddings = [
            .tinyPadding, .smallPadding, .defaultPadding, .largerDefaultPadding, .bigPadding
        ]
        
        // then
        assertSnapshot(matching: designSystemPaddings, as: .dump)
    }

}
