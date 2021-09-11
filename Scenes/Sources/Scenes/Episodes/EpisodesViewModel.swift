//
//  File.swift
//  
//
//  Created by Gabriel Marson on 11/09/21.
//

import Foundation
import Common
import NetworkLayer
import Combine

protocol EpisodesViewModelCoordinatorDelegate: AnyObject {
    
}

protocol EpisodesStateHandler: AnyObject {
    
}

final class EpisodesViewModel: ViewModel {
    
    private weak var viewControllerDelegate: EpisodesStateHandler?
    private weak var coordinatorDelegate: EpisodesViewModelCoordinatorDelegate?
    private let episodesService: GetEpisodesServices
    
    enum ViewState {
        case idle
        case loading
        case loaded(episodes: [Episode])
        case failure(error: NetworkError)
    }
    
    @Published private(set) var episodes: [Episode] = []
    @Published private(set) var state: ViewState = .idle
    
    init(episodesService: GetEpisodesServices = .init()) {
        self.episodesService = episodesService
    }
    
    func setViewControllerDelegate(stateHandler: EpisodesStateHandler) {
        viewControllerDelegate = stateHandler
    }
    
    func setCoordinatorDelegate(coordinator: EpisodesViewModelCoordinatorDelegate) {
        coordinatorDelegate = coordinator
    }
    
    func episode(at indexPath: IndexPath) -> Episode? {
        guard indexPath.row <= episodes.count else { return nil }
        return episodes[indexPath.row]
    }
    
    func getEpisodes() {
        state = .loading
        episodesService.getEpisodes { [weak self] in
            guard let self = self else { return }
            switch $0 {
            case .success(let response):
                guard let responseObject = response.responseObject else { return }
                self.episodes = responseObject.results
                self.state = .loaded(episodes: self.episodes)
            case .failure(let error):
                self.state = .failure(error: error)
            }
        }
    }
}
