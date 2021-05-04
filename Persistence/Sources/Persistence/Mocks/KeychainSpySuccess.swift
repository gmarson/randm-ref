//
//  KeychainSpySuccess.swift
//  RickAndMortyTests
//
//  Created by Gabriel Augusto Marson on 05/08/20.
//  Copyright © 2020 Gabriel Augusto Marson. All rights reserved.
//

import Foundation
import KeychainSwift
@testable import Common

#if DEBUG
final class KeychainSpySuccess: KeychainCRUD {
    
    var keychain: KeychainSwift = .init()
    
    var isInDatabaseCalled = false
    var saveCalled = false
    var retrieveCalled = false
    var removeCalled = false
    var retrieveAllCalled = false
    
    func isInDatabase(id: String) -> Bool {
        isInDatabaseCalled = true
        return true
    }
    
    func save(character: RMCharacter, completionHandler: @escaping (Result<Void, KeychainErrors>) -> Void) {
        saveCalled = true
        completionHandler(.success(()))
    }
    
    func retrieve(id: String, completionHandler: @escaping (Result<RMCharacter, KeychainErrors>) -> Void) {
        retrieveCalled = true
        completionHandler(.success(.dummy))
    }
    
    func remove(id: String, completionHandler: @escaping (Result<Void, KeychainErrors>) -> Void) {
        removeCalled = true
        completionHandler(.success(()))
    }
    
    func retrieveAll() -> [RMCharacter] {
        retrieveCalled = true
        return [.dummy]
    }
    
}
#endif
