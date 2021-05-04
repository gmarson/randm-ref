//
//  StateHandlerSpies.swift
//  RickAndMortyTests
//
//  Created by Gabriel Augusto Marson on 05/08/20.
//  Copyright © 2020 Gabriel Augusto Marson. All rights reserved.
//

import Foundation

#if DEBUG

final class StateHandlerSpies {
    var didChangeStateCharacterViewModelsCalled = false
    
    var didChangeStateSearchViewModelCalled = false
    var didLoadImageForCharacterCalled = false
    
    var didChangeStateSavedViewModelCalled = false
}

extension StateHandlerSpies: CharacterDetailViewModelStateHandler {
    func didChangeState(_ state: CharacterDetailViewModel.State) {
        didChangeStateCharacterViewModelsCalled = true
    }
}

extension StateHandlerSpies: SearchStateHandler {
    
    func didChangeState(_ state: SearchCharactersViewModel.State) {
        didChangeStateSearchViewModelCalled = true
    }
    
    func didLoadImageForCharacter(at index: IndexPath, data: Data) {
        didLoadImageForCharacterCalled = true
    }
    
}

extension StateHandlerSpies: SavedCharactersStateHandler {
    func didChangeState(_ state: SavedCharactersViewModel.State) {
        didChangeStateSavedViewModelCalled = true
    }
    
}

#endif
