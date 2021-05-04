//
//  GetImageOfCharacter.swift
//  RickAndMorty
//
//  Created by Gabriel Augusto Marson on 02/08/20.
//  Copyright © 2020 Gabriel Augusto Marson. All rights reserved.
//

import Foundation

public final class GetImageOfCharacter {
    
    private let dispatcher: NetworkDispatcher
    
    public init(dispatcher: NetworkDispatcher = .init(urlPath: "")) {
        self.dispatcher = dispatcher
    }
    
    public func getAllCharacters(
        absoluteUrl: String,
        completionHandler: @escaping (Result<Data, NetworkError>) -> Void
    ) {
        
        guard let url = URL(string: absoluteUrl) else {
            completionHandler(.failure(.badURL))
            return
        }
        
        dispatcher.downloadImage(
            url: url,
            method: .get) { result in
                completionHandler(result)
        }
    }
}
