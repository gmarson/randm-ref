//
//  File.swift
//  
//
//  Created by Gabriel Marson on 11/09/21.
//

import Foundation
import Common

public struct GetEpisodesResponse: Decodable {
    public var info: Info
    public var results: [Episode]
}

public final class GetEpisodesServices {
    
    private let dispatcher: NetworkDispatcher
    
    public init(dispatcher: NetworkDispatcher = .init(urlPath: Environment.episodes)) {
        self.dispatcher = dispatcher
    }
    
    public func getEpisodes(
        completionHandler: @escaping (Result<Response<GetEpisodesResponse>, NetworkError>) -> Void
    ) {
        dispatcher.request(
            type: GetEpisodesResponse.self,
            method: .get
        ) { result in
            completionHandler(result)
        }
    }
}
