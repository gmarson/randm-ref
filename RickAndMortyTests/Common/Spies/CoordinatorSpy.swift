//
//  CoordinatorSpy.swift
//  RickAndMortyTests
//
//  Created by Gabriel Augusto Marson on 05/08/20.
//  Copyright © 2020 Gabriel Augusto Marson. All rights reserved.
//

import Foundation
@testable import RickAndMorty

final class CoordinatorSpy: Coordinator {
    
    var startCalled = false
    var notifyAboutKeychainChangesCalled = false
    var didReceiveWarningAboutKeychainChangesCalled = false
    
    func start() {
        startCalled = true
    }
    
}

extension CoordinatorSpy: CoordinatorKeychainNotification {
    func notifyAboutKeychainChanges(sender: inout CoordinatorKeychainNotification?) {
        notifyAboutKeychainChangesCalled = true
    }
    
    func didReceiveWarningAboutKeychainChanges(sender: inout CoordinatorKeychainNotification?) {
        didReceiveWarningAboutKeychainChangesCalled = true
    }
}
