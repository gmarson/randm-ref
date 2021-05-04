//
//  SearchCharactersViewModel.swift
//  RickAndMorty
//
//  Created by Gabriel Augusto Marson on 30/07/20.
//  Copyright © 2020 Gabriel Augusto Marson. All rights reserved.
//

import Foundation
import Common
import NetworkLayer

protocol SearchStateHandler: AnyObject {
    func didChangeState(_ state: SearchCharactersViewModel.State)
    func didLoadImageForCharacter(at index: IndexPath, data: Data)
}

protocol SearchCharactersViewModelCoordinatorDelegate: Coordinator, AnyObject {
    func navigateToDetail(character: RMCharacter)
}

final class SearchCharactersViewModel: ViewModel {
    
    enum State {
        case idle
        case loading
        case loaded
        case error
    }
    
    var charactersCount: Int { characters.count }
    
    private var state: State = .idle {
        didSet {
            viewControllerDelegate?.didChangeState(state)
        }
    }
    
    private let group = DispatchGroup()
    private var charactersRequestsCounter = 0
    private var charactersResponseCounter = 0
    private weak var viewControllerDelegate: SearchStateHandler?
    private weak var coordinatorDelegate: SearchCharactersViewModelCoordinatorDelegate?
    private let charactersService: GetCharactersServices
    private let imageCharacterService: GetImageOfCharacter
    private var characters: [RMCharacter] = []
    
    init(
        charactersService: GetCharactersServices = .init(),
        imageCharacterService: GetImageOfCharacter = .init()
    ) {
        self.charactersService = charactersService
        self.imageCharacterService = imageCharacterService
    }
    
    func setCoordinatorDelegate(coordinator: SearchCharactersViewModelCoordinatorDelegate) {
        self.coordinatorDelegate = coordinator
    }
    
    func setStateHandlerDelegate(handler: SearchStateHandler) {
        viewControllerDelegate = handler
    }
    
    func getNextCharacters() {
        guard charactersRequestsCounter == charactersResponseCounter else { return }
        state = .loading
        charactersRequestsCounter += 1
        charactersService.getAllCharacters(page: charactersRequestsCounter) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                guard let characters = response.responseObject?.results else {
                    self.state = .error
                    return
                }
                self.characters.append(contentsOf: characters)
                self.state = .loaded
                self.charactersResponseCounter += 1
            case .failure:
                self.charactersRequestsCounter -= 1
                self.state = .error
            }
        }
    }
    
    func characters(at indexPath: IndexPath) -> RMCharacter? {
        guard characters.count > indexPath.row else { return nil }
        return characters[indexPath.row]
    }
    
    func setCharacterImageData(at indexPath: IndexPath, data: Data) {
        guard characters.count > indexPath.row else { return }
        characters[indexPath.row].imageData = data
    }
    
    func downloadCharacterImage(at indexPath: IndexPath) {
        guard let character = characters(at: indexPath) else {
            state = .error
            return
        }
        
        if let data = character.imageData {
            viewControllerDelegate?.didLoadImageForCharacter(at: indexPath, data: data)
            return
        }
        
        imageCharacterService.getAllCharacters(absoluteUrl: character.image) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.setCharacterImageData(at: indexPath, data: response)
                self.viewControllerDelegate?.didLoadImageForCharacter(at: indexPath, data: response)
            case .failure:
                break
            }
        }
    }
}

// MARK: - Coordinator Delegate Caller
extension SearchCharactersViewModel {
    func goToDetail(at index: IndexPath) {
        guard let character = characters(at: index) else { return }
        coordinatorDelegate?.navigateToDetail(character: character)
    }
}
