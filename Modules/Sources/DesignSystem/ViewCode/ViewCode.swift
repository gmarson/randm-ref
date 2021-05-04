//
//  ViewCode.swift
//  RickAndMorty
//
//  Created by Gabriel Augusto Marson on 31/07/20.
//  Copyright © 2020 Gabriel Augusto Marson. All rights reserved.
//

import Foundation
import UIKit

public protocol ViewCodeLifeCycle: UIView {
    func createViews()
    func addSubviews()
    func setupLayout()
    func render()
}

public extension ViewCodeLifeCycle {
    func render() {
        createViews()
        addSubviews()
        setupLayout()
    }
}

open class ViewCode<M: ViewCodeModel>: UIView, ViewCodeLifeCycle, ModelManager {
    
    public var model: M
    
    public init(model: M, frame: CGRect = .zero) {
        self.model = model
        super.init(frame: frame)
        render()
        updateModel(model: model)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func createViews() { }
    open func addSubviews() { }
    
    open func setupLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    open func updateModel(model: M) {
        self.model = model
    }

}
