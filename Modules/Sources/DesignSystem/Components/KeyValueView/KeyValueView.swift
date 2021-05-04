//
//  KeyValueView.swift
//  RickAndMorty
//
//  Created by Gabriel Augusto Marson on 03/08/20.
//  Copyright © 2020 Gabriel Augusto Marson. All rights reserved.
//

import Foundation
import UIKit

public struct KeyValueModel: ViewCodeModel {
    let key: String
    let value: String
}

public final class KeyValueView: ViewCode<KeyValueModel> {
        
    private lazy var keyLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var shortInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 2.0
        return stackView
    }()
    
    public override func addSubviews() {
        super.addSubviews()
        addSubview(keyLabel)
        addSubview(valueLabel)
    }
    
    public override func setupLayout() {
        super.setupLayout()
        addConstraints([
            keyLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            keyLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            keyLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
        
        addConstraints([
            valueLabel.leadingAnchor.constraint(equalTo: keyLabel.trailingAnchor, constant: .tinyPadding),
            valueLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)

        ])
        
        shortInfoStackView.pinToSafeArea()
    }
    
    public override func updateModel(model: KeyValueModel) {
        super.updateModel(model: model)
        keyLabel.attributedText = NSMutableAttributedString(string: model.key, attributes: [.font: UIFont.largeBold])
        valueLabel.attributedText = NSMutableAttributedString(string: model.value, attributes: [.font: UIFont.largeBold, .foregroundColor: UIColor.darkGray])
    }
    
}
