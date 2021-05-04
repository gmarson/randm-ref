//
//  KeychainSpyFailure.swift
//  RickAndMortyTests
//
//  Created by Gabriel Augusto Marson on 05/08/20.
//  Copyright © 2020 Gabriel Augusto Marson. All rights reserved.
//

import Foundation
import KeychainSwift
import Common
import Persistence

final class KeychainSpyFailure: KeychainCRUD {
    
    var keychain: KeychainSwift = .init()
    var selectedError: KeychainErrors = .unknown
    var isInDatabaseCalled = false
    var saveCalled = false
    var retrieveCalled = false
    var removeCalled = false
    var retrieveAllCalled = false
    
    func isInDatabase(id: String) -> Bool {
        isInDatabaseCalled = true
        return false
    }
    
    func save(character: RMCharacter, completionHandler: @escaping (Result<Void, KeychainErrors>) -> Void) {
        saveCalled = true
        completionHandler(.failure(selectedError))
    }
    
    func retrieve(id: String, completionHandler: @escaping (Result<RMCharacter, KeychainErrors>) -> Void) {
        retrieveCalled = true
        completionHandler(.failure(selectedError))
    }
    
    func remove(id: String, completionHandler: @escaping (Result<Void, KeychainErrors>) -> Void) {
        removeCalled = true
        completionHandler(.failure(selectedError))
    }
    
    func retrieveAll() -> [RMCharacter] {
        retrieveCalled = true
        return []
    }
    
}
