//
//  Response.swift
//  RickAndMorty
//
//  Created by Gabriel Augusto Marson on 30/07/20.
//  Copyright © 2020 Gabriel Augusto Marson. All rights reserved.
//

import Foundation

public struct Response<T: Decodable> {
    public var responseObject: T?
    public var urlRequest: URLRequest
    public var httpResponse: HTTPURLResponse?
}
