//
//  KeychainProtocolConformances.swift
//  RickAndMorty
//
//  Created by Gabriel Augusto Marson on 05/08/20.
//  Copyright © 2020 Gabriel Augusto Marson. All rights reserved.
//

import Foundation

protocol CoordinatorKeychainNotification: Coordinator, AnyObject {
    func notifyAboutKeychainChanges(sender: inout CoordinatorKeychainNotification?)
    func didReceiveWarningAboutKeychainChanges(sender: inout CoordinatorKeychainNotification?)
}

protocol ViewModelKeychainNotification: ViewModel {
    func updateKeychain()
}
