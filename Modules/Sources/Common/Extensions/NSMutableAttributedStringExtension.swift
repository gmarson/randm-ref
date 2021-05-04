//
//  NSMutableAttributedStringExtension.swift
//  RickAndMorty
//
//  Created by Gabriel Augusto Marson on 02/08/20.
//  Copyright © 2020 Gabriel Augusto Marson. All rights reserved.
//

import UIKit

public extension NSMutableAttributedString {
    
    convenience init(texts: [(text: String, font: UIFont)]) {
        self.init()
        
        texts.forEach { pair in
            self.append(NSMutableAttributedString(string: pair.text, attributes: [.font: pair.font]))
        }

    }
    
}
