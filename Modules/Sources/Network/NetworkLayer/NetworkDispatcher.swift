//
//  NetworkDispatcher.swift
//  RickAndMorty
//
//  Created by Gabriel Augusto Marson on 30/07/20.
//  Copyright © 2020 Gabriel Augusto Marson. All rights reserved.
//

import Foundation

public enum NetworkError: Int, Error {
    case badURL
    case parsing
    case forbidden
    case unauthorized
    case internalServerError
    case failedToAddQueries
    case unknown
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public typealias Headers = [String: String]

protocol NetworkDispatcherProtocol: AnyObject {
    var urlPath: URL { get }
    
    init(urlPath: String)
    func request<T: Decodable>(
        type: T.Type,
        method: HTTPMethod,
        headers: Headers?,
        payload: Data?,
        queryItems: [URLQueryItem]?,
        completionHandler: @escaping (Result<Response<T>, NetworkError>) -> Void
    )
    
    func error(_ response: URLResponse?) -> NetworkError
}

extension NetworkDispatcherProtocol {
    func error(_ response: URLResponse?) -> NetworkError {
        guard let httpResponse = response as? HTTPURLResponse else {
            return .unknown
        }
        
        switch httpResponse.statusCode {
        case 401:
            return .unauthorized
        case 403:
            return .forbidden
        case 500:
            return .internalServerError
        default:
            return .unknown
        }
    }
}

public final class NetworkDispatcher: NetworkDispatcherProtocol {
    
    // MARK: - Properties
    private(set) var urlPath: URL
    private let session = URLSession.shared
    private var defaultHeaders = ["Content-Type": "application/json"]
    
    // MARK: - Lifecycle
    /// Init method for Network dispatcher
    /// - Parameter urlPath: url path of the request
    public required init(urlPath: String) {
        self.urlPath = URL(string: Environment.baseURL + urlPath) ?? URL(fileURLWithPath: "empty")
    }
    
    // MARK: - Responses
    /// Method responsible for making request
    /// - Parameters:
    ///   - type: type of the object you want receive after request
    ///   - method: one of the HTTPMethod. (GET, POST, PUT, DELETE)
    ///   - headers: dictionary containing information. Default is nil
    ///   - payload: for POST and PUT, if you want to submit something to the server. Default is nil
    ///   - completionHandler: handler to get the response. It's either an error or  a success
    ///   - queryItems: url parameters
    public func request<T: Decodable>(
        type: T.Type,
        method: HTTPMethod,
        headers: Headers? = nil,
        payload: Data? = nil,
        queryItems: [URLQueryItem]? = nil,
        completionHandler: @escaping (Result<Response<T>, NetworkError>) -> Void
    ) {
        
        guard let urlRequest = buildRequest(
            url: addQueryItems(queryItems),
            httpMethod: method,
            httpBody: payload,
            headers: headers) else {
            completionHandler(.failure(.badURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            
            guard let self = self else { return }
            
            if error != nil {
                completionHandler(.failure(self.error(response)))
                return
            }
            
            guard let data = data, let decodedObject = try? JSONDecoder().decode(T.self, from: data) else {
                completionHandler(.failure(.parsing))
                return
            }
            
            let networkResponse: Response<T> = Response(
                responseObject: decodedObject,
                urlRequest: urlRequest,
                httpResponse: response as? HTTPURLResponse
            )
            
            completionHandler(.success(networkResponse))
        }
        
        task.resume()
    }
    
    private func buildRequest(
        url: URL,
        httpMethod: HTTPMethod,
        httpBody: Data? = nil,
        headers: Headers? = nil
    ) -> URLRequest? {
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpBody = httpBody
        urlRequest.allHTTPHeaderFields = defaultHeaders
        urlRequest.httpMethod = httpMethod.rawValue
        
        guard let headers = headers else { return urlRequest }
        
        headers.forEach {
            urlRequest.setValue($0.key, forHTTPHeaderField: $0.value)
        }
        
        return urlRequest
    }
    
    private func addQueryItems(_ items: [URLQueryItem]?) -> URL {
        guard let items = items, let queryUrl = urlPath.appending(items) else { return urlPath }
       
        return queryUrl
    }
}

// MARK: - Handling Image
extension NetworkDispatcher {
    
    func downloadImage(
        url: URL,
        method: HTTPMethod,
        completionHandler: @escaping (Result<Data, NetworkError>) -> Void
    ) {
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
                    
            guard let data = data, error == nil else { return }
            completionHandler(.success(data))
        }
        
        task.resume()
    }
}
