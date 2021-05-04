//
//  CharacterDetailViewModel.swift
//  RickAndMorty
//
//  Created by Gabriel Augusto Marson on 03/08/20.
//  Copyright © 2020 Gabriel Augusto Marson. All rights reserved.
//

import Foundation
import Network
import Common
import Persistence
import DesignSystem

protocol CharacterDetailViewModelStateHandler: AnyObject {
    func didChangeState(_ state: CharacterDetailViewModel.State)
}

final class CharacterDetailViewModel: ViewModel {
    
    enum State {
        case idle
        case loaded(_ character: RMCharacter, buttonAction: KeychainButton.Action)
        case addedToFavorites
        case removeFromFavorites
        case error
    }
    
    private var hasToNotifyAboutKeychainChanges = false
    private(set) weak var viewControllerDelegate: CharacterDetailViewModelStateHandler?
    private(set) weak var coordinatorDelegate: CoordinatorKeychainNotification?
    
    private(set) var state: State = .idle {
        didSet {
            viewControllerDelegate?.didChangeState(state)
        }
    }
    
    let character: RMCharacter
    let keychain: KeychainCRUD
    
    init(character: RMCharacter, keychainHandler: KeychainCRUD) {
        self.character = character
        self.keychain = keychainHandler
    }
    
    func setViewControllerDelegate(delegate: CharacterDetailViewModelStateHandler) {
        viewControllerDelegate = delegate
    }
    
    func setCoordinatorDelegate(delegate: CoordinatorKeychainNotification?) {
        coordinatorDelegate = delegate
    }
    
    func getCharacterInfo() {
        let action: KeychainButton.Action = keychain.isInDatabase(id: character.stringId) ? .delete : .add
        state = .loaded(character, buttonAction: action)
        viewControllerDelegate?.didChangeState(state)
    }
    
    func handleKeychainButtonAction(_ action: KeychainButton.Action) {
        (action == .add) ? save() : delete()
    }
    
    private func save() {
        keychain.save(character: character) { [weak self] in
            guard let self = self else { return }
            switch $0 {
            case .success:
                self.state = .addedToFavorites
                self.coordinatorDelegate?.notifyAboutKeychainChanges(sender: &self.coordinatorDelegate)
            case .failure:
                self.state = .error
            }
        }
    }
    
    private func delete() {
        keychain.remove(id: character.stringId) { [weak self] in
            guard let self = self else { return }
            switch $0 {
            case .success:
                self.state = .removeFromFavorites
                self.coordinatorDelegate?.notifyAboutKeychainChanges(sender: &self.coordinatorDelegate)
            case .failure:
                self.state = .error
            }
        }
    }
    
}
