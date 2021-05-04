//
//  CharacterDummy.swift
//  RickAndMortyTests
//
//  Created by Gabriel Augusto Marson on 05/08/20.
//  Copyright © 2020 Gabriel Augusto Marson. All rights reserved.
//

import Foundation
@testable import RickAndMorty

extension Character {
    static var dummy: Character {
        .init(
            id: 0,
            name: "",
            status: "",
            species: "",
            type: "",
            gender: "",
            origin: .init(name: "", url: ""),
            location: .init(name: "", url: ""),
            image: "",
            episode: [],
            url: "",
            created: "",
            imageData: nil
        )
    }
}

extension Character: Equatable {
    public static func == (lhs: Character, rhs: Character) -> Bool {
        return lhs.id == rhs.id &&
            lhs.name == rhs.name
    }
}
