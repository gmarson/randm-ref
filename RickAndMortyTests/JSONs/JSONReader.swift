//
//  JSONReader.swift
//  RickAndMortyTests
//
//  Created by Gabriel Augusto Marson on 01/08/20.
//  Copyright © 2020 Gabriel Augusto Marson. All rights reserved.
//

import Foundation
@testable import RickAndMorty

enum JSONError: Error {
    case wrongUrl
}

class JSONReader {
    static func read<T: Decodable>(from file: String, outputType: T.Type) throws -> T {
        
        guard let url = Bundle(for: JSONReader.self).url(forResource: file, withExtension: ".json"),
            let data = try? Data(contentsOf: url) else {
            throw JSONError.wrongUrl
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
