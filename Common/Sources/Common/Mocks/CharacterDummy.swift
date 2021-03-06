//
//  CharacterDummy.swift
//  RickAndMortyTests
//
//  Created by Gabriel Augusto Marson on 05/08/20.
//  Copyright © 2020 Gabriel Augusto Marson. All rights reserved.
//

import Foundation

#if DEBUG

public extension RMCharacter {
    static var dummy: RMCharacter {
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

extension RMCharacter: Equatable {
    public static func == (lhs: RMCharacter, rhs: RMCharacter) -> Bool {
        return lhs.id == rhs.id &&
            lhs.name == rhs.name
    }
}

#endif
