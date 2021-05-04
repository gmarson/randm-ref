//
//  UIViewExtension.swift
//  RickAndMorty
//
//  Created by Gabriel Augusto Marson on 31/07/20.
//  Copyright © 2020 Gabriel Augusto Marson. All rights reserved.
//

import UIKit

public extension UIView {
    
    /// Add Size Constraints to caller
    /// - Parameters:
    ///   - height: amount of height
    ///   - width: amount of width
    func sizeConstraints(height: CGFloat, width: CGFloat) {
        
        addConstraints([
            heightAnchor.constraint(equalToConstant: height),
            widthAnchor.constraint(equalToConstant: width)
        ])
    }
    
    /// If superview exists, than this method centers the child component in the midle of the superview.
    func centerToSuperView() {
        guard let superView = superview else { return }
        
        superView.addConstraints([
            centerYAnchor.constraint(equalTo: superView.centerYAnchor),
            centerXAnchor.constraint(equalTo: superView.centerXAnchor)
        ])
    }
    
    /// If superview exists, than this method sets leading, trailing, top and bottom constraints to be equal to superview
    /// - Parameters:
    ///   - leading: leading constant offset
    ///   - trailing: trailing constant offset
    ///   - top: top constant offset
    ///   - bottom: bottom constant offset
    func pinToSuperView(
        leading: CGFloat = 0.0,
        trailing: CGFloat = 0.0,
        top: CGFloat = 0.0,
        bottom: CGFloat = 0.0
    ) {
        guard let superView = superview else { return }
        
        superView.addConstraints([
            
            leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: leading),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: trailing),
            topAnchor.constraint(equalTo: superView.topAnchor, constant: top),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: bottom)
        ])
    }
    
    /// If superview exists, than this method sets leading, trailing, top and bottom constraints to be equal to safe area
    /// - Parameters:
    ///   - leading: leading constant offset
    ///   - trailing: trailing constant offset
    ///   - top: top constant offset
    ///   - bottom: bottom constant offset
    func pinToSafeArea(
        leading: CGFloat = 0.0,
        trailing: CGFloat = 0.0,
        top: CGFloat = 0.0,
        bottom: CGFloat = 0.0
    ) {
       
        guard let superView = superview else { return }
        
        superView.addConstraints([
            leadingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.leadingAnchor, constant: leading),
            trailingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.trailingAnchor, constant: trailing),
            topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor, constant: top),
            bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor, constant: bottom)
        ])
        
    }
}
