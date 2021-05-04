//
//  KeychainButtonSnapshotTest.swift
//  RickAndMortyTests
//
//  Created by Gabriel Augusto Marson on 05/08/20.
//  Copyright © 2020 Gabriel Augusto Marson. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import DesignSystem

final class KeychainButtonSnapshotTest: XCTestCase {

    private let buttonFrame: CGRect =  .init(origin: .zero, size: .init(width: 250.0, height: 50.0))
    
    func testRemovalLayout() throws {
        // given
        let button = KeychainButton(model: .init(action: .delete))
        let view = UIView(frame: buttonFrame)
        
        // when
        view.addSubview(button)
        button.pinToSuperView()
    
        // then
        assertSnapshot(matching: view, as: .image)
    }
    
    func testAdditionLayout() throws {
        // given
        let button = KeychainButton(model: .init(action: .add))
        let view = UIView(frame: buttonFrame)
        
        // when
        view.addSubview(button)
        button.pinToSuperView()
    
        // then
        assertSnapshot(matching: view, as: .image)
    }
    
}
