//
//  ApplicationCoordinator.swift
//  RickAndMorty
//
//  Created by Gabriel Augusto Marson on 30/07/20.
//  Copyright © 2020 Gabriel Augusto Marson. All rights reserved.
//

import UIKit
import Common
import Persistence

public final class ApplicationCoordinator: Coordinator, AplicationCoordinatorDependencies {
   
    let window: UIWindow
    let rootViewController: UITabBarController
    let searchCharactersCoordinator: SearchCharactersCoordinator
    let savedCharactersCoordinator: SavedCharactersCoordinator
    let episodesCoordinator: EpisodesCoordinator
    
    var applicationKeychain: KeychainCRUD
    
    public init(
        window: UIWindow,
        keychain: KeychainCRUD = KeychainHandler()
    ) {
        self.window = window
        self.applicationKeychain = keychain
        rootViewController = UITabBarController()
        searchCharactersCoordinator = .init(tabBarController: rootViewController)
        savedCharactersCoordinator = .init(tabBarController: rootViewController)
        episodesCoordinator = .init(tabBarController: rootViewController)
    }
    
    public func start() {
        
        #if DEBUG
        if CommandLine.arguments.contains("uitest") {
            configForUITest()
        }
        #endif
        
        window.rootViewController = rootViewController
        
        searchCharactersCoordinator.parentCoordinatorDelegate = self
        searchCharactersCoordinator.start()
        
        savedCharactersCoordinator.parentCoordinatorDelegate = self
        savedCharactersCoordinator.start()
        
        episodesCoordinator.parentCoordinatorDelegate = self
        episodesCoordinator.start()
        
        window.makeKeyAndVisible()
    }
}

extension ApplicationCoordinator: CoordinatorKeychainNotification {
    func notifyAboutKeychainChanges(sender: inout CoordinatorKeychainNotification?) {
        didReceiveWarningAboutKeychainChanges(sender: &sender)
    }
    
    func didReceiveWarningAboutKeychainChanges(sender: inout CoordinatorKeychainNotification?) {
        savedCharactersCoordinator.didReceiveWarningAboutKeychainChanges(sender: &sender)
    }
   
}

extension ApplicationCoordinator: SearchCoordinatorToAppCoordinatorDelegate { }
extension ApplicationCoordinator: SavedCoordinatorToAppCoordinatorDelegate { }
extension ApplicationCoordinator: EpisodeCoordinatorToAppCoordinatorDelegate { }

#if DEBUG
private extension ApplicationCoordinator {
    func configForUITest() {
        (applicationKeychain as? KeychainHandler)?.deleteDatabase()
    }
}
#endif
