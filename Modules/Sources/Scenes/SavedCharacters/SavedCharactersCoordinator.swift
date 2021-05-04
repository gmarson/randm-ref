//
//  SavedCharactersCoordinator.swift
//  RickAndMorty
//
//  Created by Gabriel Augusto Marson on 30/07/20.
//  Copyright © 2020 Gabriel Augusto Marson. All rights reserved.
//

import UIKit
import Persistence

protocol SavedCoordinatorToAppCoordinatorDelegate: Coordinator {
    var applicationKeychain: KeychainCRUD { get }
}

final class SavedCharactersCoordinator: Coordinator {
    
    private let tabBarController: UITabBarController
    private let navigationController: UINavigationController
    weak var parentCoordinatorDelegate: (SavedCoordinatorToAppCoordinatorDelegate & CoordinatorKeychainNotification)?
    
    var viewModels: [ViewModel] = []
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
        navigationController = UINavigationController()
    }
    
    func start() {
        navigationController.viewControllers = [buildSavedViewController()]
        setupTabBar()
    }
    
    private func setupTabBar() {
        tabBarController.viewControllers?.append(navigationController)
        tabBarController.tabBar.items?[1].title = "Saved"
        tabBarController.tabBar.items?[1].image = #imageLiteral(resourceName: "save")
    }
    
    private func buildSavedViewController() -> UIViewController {
        guard let keychain = parentCoordinatorDelegate?.applicationKeychain else { return .init() }
        let viewModel = SavedCharactersViewModel(keychain: keychain)
        let savedCharacterViewController = SavedCharactersViewController(viewModel: viewModel)
        viewModel.setCoordinatorDelegate(coordinator: self)
        viewModel.setViewControllerDelegate(stateHandler: savedCharacterViewController)
        viewModels.append(viewModel)
        return savedCharacterViewController
    }
    
}

extension SavedCharactersCoordinator: SavedCharactersViewModelCoordinatorDelegate {
    func navigateToDetail(character: Character) {
        guard let viewController = buildDetailViewController(character) else { return }
        
        navigationController.present(
            viewController,
            animated: true,
            completion: nil
        )
    }
    
    private func buildDetailViewController(_ character: Character) -> CharacterDetailViewController? {
        guard let keychain = parentCoordinatorDelegate?.applicationKeychain else { return nil }
        let viewModel = CharacterDetailViewModel(character: character, keychainHandler: keychain)
        let viewController = CharacterDetailViewController(viewModel: viewModel)
        viewModel.setViewControllerDelegate(delegate: viewController)
        viewModel.setCoordinatorDelegate(delegate: self)
        viewModels.append(viewModel)
        return viewController
    }
}

extension SavedCharactersCoordinator: CoordinatorKeychainNotification {
    func notifyAboutKeychainChanges(sender: inout CoordinatorKeychainNotification?) {
        parentCoordinatorDelegate?.notifyAboutKeychainChanges(sender: &sender)
    }
    
    func didReceiveWarningAboutKeychainChanges(sender: inout CoordinatorKeychainNotification?) {
        viewModels.forEach {
            ($0 as? ViewModelKeychainNotification)?.updateKeychain()
        }
    }
}
