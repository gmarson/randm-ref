//
//  KeychainButton.swift
//  RickAndMorty
//
//  Created by Gabriel Augusto Marson on 04/08/20.
//  Copyright © 2020 Gabriel Augusto Marson. All rights reserved.
//

import Foundation
import UIKit

public protocol KeychainButtonDelegate: AnyObject {
    func didTouchUpInside(_ action: KeychainButton.Action)
}

public struct KeychainButtonModel: ViewCodeModel {
    
    var action: KeychainButton.Action
    
    public init(action: KeychainButton.Action) {
        self.action = action
    }
}

public final class KeychainButton: ViewCode<KeychainButtonModel> {
    
    private struct Constants {
        var add = "Add to favorites"
        var remove = "Remove from favorites"
    }
    
    public enum Action {
        case add
        case delete
    }
    
    private let c = Constants()
    
    public weak var delegate: KeychainButtonDelegate?
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTouchUpInside), for: .touchUpInside)
        button.backgroundColor = .clear
        return button
    }()
    
    public override func createViews() {
        super.createViews()
        self.accessibilityIdentifier = "KeychainButton"
    }
    
    public override func addSubviews() {
        super.addSubviews()
        addSubview(button)
    }
    
    public override func setupLayout() {
        super.setupLayout()
        button.pinToSafeArea()
        
        layer.cornerRadius = 5.0
        layer.masksToBounds = true
    }
    
    public override func updateModel(model: KeychainButtonModel) {
        super.updateModel(model: model)
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white, .font: UIFont.largeBold]
        
        switch model.action {
        
        case .add:
            button.setAttributedTitle(.init(string: c.add, attributes: attributes), for: .normal)
            backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        case .delete:
            button.setAttributedTitle(.init(string: c.remove, attributes: attributes), for: .normal)
            backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        }
    }
    
    @objc private func didTouchUpInside() {
        delegate?.didTouchUpInside(model.action)
    }
    
}
