//
//  KeyValueViewSnapshotTests.swift
//  RickAndMortyTests
//
//  Created by Gabriel Augusto Marson on 05/08/20.
//  Copyright © 2020 Gabriel Augusto Marson. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import DesignSystem

final class KeyValueViewSnapshotTests: XCTestCase {

    private let viewFrame: CGRect = .init(origin: .zero, size: .init(width: 200, height: 400))
    
    func testSmallExample() throws {
        // given
        let view = UIView(frame: viewFrame)
        let keyValueView = KeyValueView(model: .init(key: "Small key", value: "Small value"))
        keyValueView.backgroundColor = .lightGray
        view.backgroundColor = .white
        
        // when
        view.addSubview(keyValueView)
        view.addConstraints([
            keyValueView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            keyValueView.topAnchor.constraint(equalTo: view.topAnchor),
            keyValueView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // then
        assertSnapshot(matching: view, as: .image)
    }

    func testBigExample() throws {
        // given
        let view = UIView(frame: viewFrame)
        let keyValueView = KeyValueView(model: .init(key: "Small key", value: "Big Value Big Value Big Value"))
        keyValueView.backgroundColor = .lightGray
        view.backgroundColor = .white
        
        // when
        view.addSubview(keyValueView)
        view.addConstraints([
            keyValueView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            keyValueView.topAnchor.constraint(equalTo: view.topAnchor),
            keyValueView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // then
        assertSnapshot(matching: view, as: .image)
    }
}
