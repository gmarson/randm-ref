//
//  KeychainHandler.swift
//  RickAndMorty
//
//  Created by Gabriel Augusto Marson on 03/08/20.
//  Copyright © 2020 Gabriel Augusto Marson. All rights reserved.
//

import Foundation
import KeychainSwift
import Network
import Common

public protocol KeychainCRUD: AnyObject {
    
    var keychain: KeychainSwift { get }
    
    func isInDatabase(id: String) -> Bool
    func save(character: RMCharacter, completionHandler: @escaping (Result<Void, KeychainErrors>) -> Void)
    func retrieve(id: String, completionHandler: @escaping (Result<RMCharacter, KeychainErrors>) -> Void)
    func remove(id: String, completionHandler: @escaping (Result<Void, KeychainErrors>) -> Void)
    func retrieveAll() -> [RMCharacter]
}

public enum KeychainErrors: Error {
    case encoding
    case decoding
    case dataNotFound
    case unknown
    case couldNotDelete
}

public final class KeychainHandler: KeychainCRUD {
   
    public let keychain = KeychainSwift()
    private var savedCharacters = [String]() {
        didSet {
            UserDefaults.standard.set(savedCharacters, forKey: userDefaultsKey)
        }
    }
    
    private let userDefaultsKey = "key"
    
    public init() {
        savedCharacters = UserDefaults.standard.stringArray(forKey: userDefaultsKey) ?? [String]()
    }
    
    public func isInDatabase(id: String) -> Bool {
        return savedCharacters.contains { id == $0 }
    }
    
    public func save(character: RMCharacter, completionHandler: @escaping (Result<Void, KeychainErrors>) -> Void) {
        guard let encoded = try? JSONEncoder().encode(character) else {
            completionHandler(.failure(.encoding))
            return
        }
        
        keychain.set(encoded, forKey: character.stringId)
        savedCharacters.append(character.stringId)
        
        completionHandler(.success(()))
    }
    
    public func retrieve(id: String, completionHandler: @escaping (Result<RMCharacter, KeychainErrors>) -> Void) {
        guard let data = keychain.getData(id) else {
            completionHandler(.failure(.dataNotFound))
            return
        }
        
        guard let decoded = try? JSONDecoder().decode(RMCharacter.self, from: data) else {
            completionHandler(.failure(.decoding))
            return
        }
        
        completionHandler(.success(decoded))
    }
    
    public func remove(id: String, completionHandler: @escaping (Result<Void, KeychainErrors>) -> Void) {
        guard keychain.delete(id), let index = findIndex(with: id) else {
            completionHandler(.failure(.couldNotDelete))
            return
        }
        savedCharacters.remove(at: index)
        completionHandler(.success(()))
    }
    
    private func findIndex(with id: String) -> Int? {
        savedCharacters.firstIndex { $0 == id }
    }
    
    // TODO: change this
    public func deleteDatabase() {
        savedCharacters = [String]()
        keychain.clear()
    }
    
    public func retrieveAll() -> [RMCharacter] {
        var characters = [RMCharacter]()
        savedCharacters.forEach {
            retrieve(id: $0) { result in
                switch result {
                case .success(let item):
                    characters.append(item)
                case .failure:
                    // in the future, use nslog to detail the error
                    break
                }
            }
        }

        return characters
    }
}
