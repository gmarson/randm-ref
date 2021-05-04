//
//  Info.swift
//  RickAndMorty
//
//  Created by Gabriel Augusto Marson on 30/07/20.
//  Copyright © 2020 Gabriel Augusto Marson. All rights reserved.
//

import Foundation

public struct Info: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
