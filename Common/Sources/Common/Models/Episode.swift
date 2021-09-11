//
//  Episode.swift
//  
//
//  Created by Gabriel Marson on 11/09/21.
//

import Foundation

public struct Episode: Decodable {
    
    let id: Int
    public let name: String
    public let airDate: String
    public let episodeNumber: String
    public let characters: [String]
    let url: String
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case airDate = "air_date"
        case episodeNumber = "episode"
        case characters
        case url
        case createdAt = "created"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        airDate = try values.decode(String.self, forKey: .airDate)
        episodeNumber = try values.decode(String.self, forKey: .episodeNumber)
        characters = try values.decode([String].self, forKey: .characters)
        url = try values.decode(String.self, forKey: .url)
        createdAt = try values.decode(String.self, forKey: .createdAt)
    }
    
}
