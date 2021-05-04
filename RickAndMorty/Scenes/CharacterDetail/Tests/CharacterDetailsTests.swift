//
//  CharacterDetailsTests.swift
//  RickAndMortyTests
//
//  Created by Gabriel Augusto Marson on 05/08/20.
//  Copyright © 2020 Gabriel Augusto Marson. All rights reserved.
//

import XCTest
@testable import RickAndMorty

class CharacterDetailsTests: XCTestCase {
    
    func testIdleState() throws {
        // given
        let viewModel = CharacterDetailViewModel(character: .dummy, keychainHandler: KeychainSpyFailure())
        
        // then
        XCTAssertEqual(viewModel.state, .idle)
    }
    
    func testGetCharacterInfoWithSuccess() {
        // given
        let inputCharacter: Character = .dummy
        let viewModel = CharacterDetailViewModel(character: inputCharacter, keychainHandler: KeychainSpySuccess())
        
        // when
        viewModel.getCharacterInfo()
        
        // then
        XCTAssertEqual(viewModel.state, .loaded(inputCharacter, buttonAction: .delete))
    }
    
    func testGetCharacterInfoWithFailure() {
       // given
       let inputCharacter: Character = .dummy
       let viewModel = CharacterDetailViewModel(character: inputCharacter, keychainHandler: KeychainSpyFailure())
       
       // when
       viewModel.getCharacterInfo()
       
       // then
       XCTAssertEqual(viewModel.state, .loaded(inputCharacter, buttonAction: .add))
    }
    
    func testHandleKeychainButtonActionForFailure() {
        // given
        let inputCharacter: Character = .dummy
        let viewModelAddAction = CharacterDetailViewModel(character: inputCharacter, keychainHandler: KeychainSpyFailure())
        let viewModelDeleteAction = CharacterDetailViewModel(character: inputCharacter, keychainHandler: KeychainSpyFailure())
        
        // when
        viewModelAddAction.handleKeychainButtonAction(.add)
        viewModelDeleteAction.handleKeychainButtonAction(.delete)
        
        // then
        XCTAssertEqual(viewModelAddAction.state, .error)
        XCTAssertEqual(viewModelDeleteAction.state, .error)
    }
    
    func testHandleKeychainAddButtonActionForSuccess() {
        // given
        let inputCharacter: Character = .dummy
        let viewModelAddAction = CharacterDetailViewModel(character: inputCharacter, keychainHandler: KeychainSpySuccess())
        
        // when
        viewModelAddAction.handleKeychainButtonAction(.add)
        
        // then
        XCTAssertEqual(viewModelAddAction.state, .addedToFavorites)
    }
    
    func testHandleKeychainRemoveButtonActionForSuccess() {
        // given
        let inputCharacter: Character = .dummy
        let viewModelAddAction = CharacterDetailViewModel(character: inputCharacter, keychainHandler: KeychainSpySuccess())
        
        // when
        viewModelAddAction.handleKeychainButtonAction(.delete)
        
        // then
        XCTAssertEqual(viewModelAddAction.state, .removeFromFavorites)
    }
    
    func testDelegationAttributionForLeaks() {
        // given
        var coordinatorDelegate: CoordinatorSpy = CoordinatorSpy()
        var stateHandlerDelegate: StateHandlerSpies = StateHandlerSpies()
        let viewModel: CharacterDetailViewModel = CharacterDetailViewModel(character: .dummy, keychainHandler: KeychainSpySuccess())
        
        // when
        viewModel.setCoordinatorDelegate(delegate: coordinatorDelegate)
        viewModel.setViewControllerDelegate(delegate: stateHandlerDelegate)
        coordinatorDelegate = CoordinatorSpy()
        stateHandlerDelegate = StateHandlerSpies()
        
        // then
        XCTAssertNil(viewModel.coordinatorDelegate)
        XCTAssertNil(viewModel.viewControllerDelegate)
        
    }
    
}

//swiftlint:disable pattern_matching_keywords
extension CharacterDetailViewModel.State: Equatable {
    public static func == (lhs: CharacterDetailViewModel.State, rhs: CharacterDetailViewModel.State) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle):
            return true
        case (.addedToFavorites, .addedToFavorites):
            return true
        case (.removeFromFavorites, removeFromFavorites):
            return true
        case (.error, .error):
            return true
        case (let .loaded(lhsc, lhsa), let .loaded(rhsc, rhsa)):
            return lhsc == rhsc && lhsa == rhsa
        default:
            return false
        }
    }
    
}
