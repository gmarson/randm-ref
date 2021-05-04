//
//  ApplicationCoordinatorDependencies.swift
//  RickAndMorty
//
//  Created by Gabriel Augusto Marson on 02/05/21.
//  Copyright © 2021 Gabriel Augusto Marson. All rights reserved.
//

import Foundation
import Persistence

protocol HasKeychain: AnyObject {
    var applicationKeychain: KeychainCRUD { get }
}

protocol AplicationCoordinatorDependencies: Coordinator, HasKeychain {
    
}
