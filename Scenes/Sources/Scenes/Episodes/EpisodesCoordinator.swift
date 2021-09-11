//
//  File.swift
//  
//
//  Created by Gabriel Marson on 11/09/21.
//

import Foundation
import UIKit

protocol EpisodeCoordinatorToAppCoordinatorDelegate: Coordinator, AnyObject {
    
}

final class EpisodesCoordinator: Coordinator {
    
    private let tabBarController: UITabBarController
    private let navigationController: UINavigationController
    weak var parentCoordinatorDelegate: EpisodeCoordinatorToAppCoordinatorDelegate?
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
        navigationController = UINavigationController()
    }
    
    func start() {
        setupTabBar()
        navigationController.pushViewController(buildEpisodesViewController(), animated: false)
    }
    
    private func setupTabBar() {
        tabBarController.viewControllers?.append(navigationController)
        tabBarController.tabBar.items?[2].title = "Episodes"
        tabBarController.tabBar.items?[2].image = #imageLiteral(resourceName: "rickFace")
    }
    
    private func buildEpisodesViewController() -> UIViewController {
        let viewModel = EpisodesViewModel()
        let episodeViewController = EpisodesViewController(viewModel: viewModel)
        viewModel.setCoordinatorDelegate(coordinator: self)
        viewModel.setViewControllerDelegate(stateHandler: episodeViewController)
        return episodeViewController
    }
    
}

extension EpisodesCoordinator: EpisodesViewModelCoordinatorDelegate {
    
}
