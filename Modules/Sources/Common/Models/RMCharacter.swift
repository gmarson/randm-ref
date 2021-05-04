//
//  RMCharacter.swift
//  RickAndMorty
//
//  Created by Gabriel Augusto Marson on 30/07/20.
//  Copyright © 2020 Gabriel Augusto Marson. All rights reserved.
//

import Foundation

public struct RMCharacter: Codable {
    let id: Int
    public let name: String
    public let status: String
    let species: String
    let type: String
    public let gender: String
    public let origin: NameAndUrl
    let location: NameAndUrl
    public let image: String
    let episode: [String]
    let url: String
    let created: String
    
    public var imageData: Data?
    
}

//TODO: do a DTO
public struct RMCharacterDTO {
    
    
    
}

public extension RMCharacter {
    var stringId: String { "\(id)" }
}
