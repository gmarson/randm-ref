//
//  JSONReader.swift
//  RickAndMortyTests
//
//  Created by Gabriel Augusto Marson on 01/08/20.
//  Copyright © 2020 Gabriel Augusto Marson. All rights reserved.
//

import Foundation
@testable import RickAndMorty
import XCTest

enum JSONError: Error {
    case wrongUrl
}

class JSONHandler {
    static func read<T: Decodable>(from file: String, outputType: T.Type) throws -> T {
        let data = fileToData(file: file)
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    static func fileToData(file: String) -> Data {
        guard let url = Bundle(for: JSONHandler.self).url(forResource: file, withExtension: ".json"),
            let data = try? Data(contentsOf: url) else {
            assertionFailure("Failed to convert to data")
            return Data()
        }
        return data
    }
    
}
