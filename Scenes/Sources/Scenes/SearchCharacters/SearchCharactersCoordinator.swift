//
//  SearchCharactersCoordinator.swift
//  RickAndMorty
//
//  Created by Gabriel Augusto Marson on 30/07/20.
//  Copyright © 2020 Gabriel Augusto Marson. All rights reserved.
//

import UIKit
import Persistence
import Common

protocol SearchCoordinatorToAppCoordinatorDelegate: Coordinator, AnyObject {
    var applicationKeychain: KeychainCRUD { get }
}

final class SearchCharactersCoordinator: Coordinator {
    
    private let tabBarController: UITabBarController
    private let navigationController: UINavigationController
    weak var parentCoordinatorDelegate: (SearchCoordinatorToAppCoordinatorDelegate & CoordinatorKeychainNotification)?
    var viewModels: [ViewModel] = []
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
        navigationController = UINavigationController()
    }
    
    func start() {
        let viewModel = SearchCharactersViewModel()
        viewModel.setCoordinatorDelegate(coordinator: self)
        let searchCharacterViewController = SearchCharactersViewController(viewModel: viewModel)
        viewModel.setStateHandlerDelegate(handler: searchCharacterViewController)
        viewModels.append(viewModel)
        navigationController.viewControllers = [searchCharacterViewController]
        setupTabBar()
    }
    
    private func setupTabBar() {
        tabBarController.viewControllers = [navigationController]
        tabBarController.tabBar.items?[0].title = "Search"
        tabBarController.tabBar.items?[0].image = #imageLiteral(resourceName: "search")
    }
    
}

extension SearchCharactersCoordinator: SearchCharactersViewModelCoordinatorDelegate {
    func navigateToDetail(character: RMCharacter) {
        guard let viewController = buildDetailViewController(character) else { return }
        
        navigationController.present(
            viewController,
            animated: true,
            completion: nil
        )
    }
    
    private func buildDetailViewController(_ character: RMCharacter) -> CharacterDetailViewController? {
        guard let keychain = parentCoordinatorDelegate?.applicationKeychain else { return nil }
        let viewModel = CharacterDetailViewModel(character: character, keychainHandler: keychain)
        
        let viewController = CharacterDetailViewController(viewModel: viewModel)
        viewModel.setViewControllerDelegate(delegate: viewController)
        viewModel.setCoordinatorDelegate(delegate: self)
        viewModels.append(viewModel)
        return viewController
    }

}

extension SearchCharactersCoordinator: CoordinatorKeychainNotification {
    func notifyAboutKeychainChanges(sender: inout CoordinatorKeychainNotification?) {
        parentCoordinatorDelegate?.notifyAboutKeychainChanges(sender: &sender)
    }
    
    func didReceiveWarningAboutKeychainChanges(sender: inout CoordinatorKeychainNotification?) {
        viewModels.forEach {
            ($0 as? ViewModelKeychainNotification)?.updateKeychain()
        }
    }
}
