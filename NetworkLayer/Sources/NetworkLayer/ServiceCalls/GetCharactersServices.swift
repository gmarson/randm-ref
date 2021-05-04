//
//  SearchCharactersServices.swift
//  RickAndMorty
//
//  Created by Gabriel Augusto Marson on 01/08/20.
//  Copyright © 2020 Gabriel Augusto Marson. All rights reserved.
//

import Foundation
import Common

public struct GetAllCharactersResponse: Decodable {
    public var info: Info
    public var results: [RMCharacter]
}

public final class GetCharactersServices {
    
    private let dispatcher: NetworkDispatcher
    
    public init(dispatcher: NetworkDispatcher = .init(urlPath: Environment.characters)) {
        self.dispatcher = dispatcher
    }
    
    public func getAllCharacters(
        page: Int,
        completionHandler: @escaping (Result<Response<GetAllCharactersResponse>, NetworkError>) -> Void
    ) {
        
        let query: URLQueryItem = .init(name: "page", value: "\(page)")
        
        dispatcher.request(
            type: GetAllCharactersResponse.self,
            method: .get,
            queryItems: [query]
        ) { result in
            completionHandler(result)
        }
    }
}
