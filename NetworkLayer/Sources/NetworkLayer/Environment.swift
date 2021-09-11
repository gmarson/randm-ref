//
//  Environment.swift
//  RickAndMorty
//
//  Created by Gabriel Augusto Marson on 30/07/20.
//  Copyright © 2020 Gabriel Augusto Marson. All rights reserved.
//

import Foundation

public struct Environment {
    
    // MARK: - Properties
    public static var baseURL: String {
        
        var base = "https://rickandmortyapi.com/api/"
        
        #if DEBUG
            
            guard CommandLine.arguments.contains("localHost") else {
                return base
            }
            
            base = "http://localhost:8080/"
        
        #endif
        
        return base
    }
    
    public static var characters: String { "character/" }
    public static var episodes: String { "episode/" }
}
