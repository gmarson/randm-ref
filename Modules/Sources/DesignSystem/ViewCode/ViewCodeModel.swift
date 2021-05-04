//
//  ViewCodeModel.swift
//  RickAndMorty
//
//  Created by Gabriel Augusto Marson on 31/07/20.
//  Copyright © 2020 Gabriel Augusto Marson. All rights reserved.
//

import Foundation

public protocol ViewCodeModel { }

public struct EmptyModel: ViewCodeModel {
    public init() { }
}

public protocol ModelManager {
    associatedtype SomeModel: ViewCodeModel
    
    var model: SomeModel { get set }
    
    func updateModel(model: SomeModel)
}

public protocol OptionalModelManager {
    associatedtype SomeModel: ViewCodeModel
    
    var model: SomeModel? { get set }
    
    func updateModel(model: SomeModel?)
}
