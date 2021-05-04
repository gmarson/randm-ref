//
//  SavedCharactersViewModel.swift
//  RickAndMorty
//
//  Created by Gabriel Augusto Marson on 30/07/20.
//  Copyright © 2020 Gabriel Augusto Marson. All rights reserved.
//

import Foundation
import Common
import Persistence

protocol SavedCharactersStateHandler: AnyObject {
    func didChangeState(_ state: SavedCharactersViewModel.State)
}

protocol SavedCharactersViewModelCoordinatorDelegate: Coordinator {
    func navigateToDetail(character: RMCharacter)
}

final class SavedCharactersViewModel: ViewModelKeychainNotification {

    private let keychain: KeychainCRUD
    private weak var viewControllerDelegate: SavedCharactersStateHandler?
    private weak var coordinatorDelegate: SavedCharactersViewModelCoordinatorDelegate?
    private var characters: [RMCharacter] = []
    
    enum State {
        case idle
        case empty
        case loaded
    }
    
    var charactersCount: Int { characters.count }
    
    var state: State = .idle {
        didSet {
            viewControllerDelegate?.didChangeState(state)
        }
    }
    
    init(keychain: KeychainCRUD) {
        self.keychain = keychain
    }
    
    func setViewControllerDelegate(stateHandler: SavedCharactersStateHandler) {
        viewControllerDelegate = stateHandler
    }
    
    func setCoordinatorDelegate(coordinator: SavedCharactersViewModelCoordinatorDelegate) {
        coordinatorDelegate = coordinator
    }
    
    func characters(at indexPath: IndexPath) -> RMCharacter? {
        guard characters.count > indexPath.row else { return nil }
        return characters[indexPath.row]
    }
    
    func getAllCharacters() {
        characters = keychain.retrieveAll()
        state = characters.count == 0 ? .empty : .loaded
    }
    
}

// MARK: - Coordinator Delegate Caller
extension SavedCharactersViewModel {
    func goToDetail(at index: IndexPath) {
        guard let character = characters(at: index) else { return }
        coordinatorDelegate?.navigateToDetail(character: character)
    }
}

// MARK: - Keychain Notification
extension SavedCharactersViewModel {
    func updateKeychain() {
        getAllCharacters()
    }
}
