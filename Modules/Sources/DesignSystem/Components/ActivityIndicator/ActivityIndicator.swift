//
//  ActivityIndicator.swift
//  RickAndMorty
//
//  Created by Gabriel Augusto Marson on 01/08/20.
//  Copyright © 2020 Gabriel Augusto Marson. All rights reserved.
//

import UIKit

public final class ActivityIndicator: ViewCode<EmptyModel> {
    
    var loadingView: UIView = {
        let loadingView = UIView()
        loadingView.backgroundColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 0.602618838)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        return loadingView
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    public override func addSubviews() {
        super.addSubviews()
        addSubview(loadingView)
        loadingView.addSubview(activityIndicator)
    }
    
    public override func setupLayout() {
        super.setupLayout()
        loadingView.pinToSafeArea()
        activityIndicator.centerToSuperView()
    }
    
    public override func updateModel(model: EmptyModel) {
        super.updateModel(model: model)
    }
    
    public func startAnimating() {
        activityIndicator.startAnimating()
    }
    
    public func stopAnimating() {
        self.isHidden = true
        activityIndicator.stopAnimating()
    }
    
}
