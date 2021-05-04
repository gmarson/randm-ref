//
//  DesignSystem.swift
//  RickAndMorty
//
//  Created by Gabriel Augusto Marson on 02/08/20.
//  Copyright © 2020 Gabriel Augusto Marson. All rights reserved.
//

import UIKit

public extension UIFont {
    
    private enum Sizes: CGFloat {
        case tiny = 8.0
        case small = 10.0
        case regular = 12.0
        case large = 20.0
        case huge = 30.0
    }
    
    // MARK: - Bold
    static var tinyBold: UIFont { .boldSystemFont(ofSize: Sizes.tiny.rawValue) }
    static var smallBold: UIFont { .boldSystemFont(ofSize: Sizes.small.rawValue) }
    static var regularBold: UIFont { .boldSystemFont(ofSize: Sizes.regular.rawValue) }
    static var largeBold: UIFont { .boldSystemFont(ofSize: Sizes.large.rawValue) }
    static var hugeBold: UIFont { .boldSystemFont(ofSize: Sizes.huge.rawValue) }
    
    // MARK: - Italic
    static var tinyItalic: UIFont { .italicSystemFont(ofSize: Sizes.tiny.rawValue) }
    static var smallItalic: UIFont { .italicSystemFont(ofSize: Sizes.small.rawValue) }
    static var regularItalic: UIFont { .italicSystemFont(ofSize: Sizes.regular.rawValue) }
    static var largeItalic: UIFont { .italicSystemFont(ofSize: Sizes.large.rawValue) }
    static var hugeItalic: UIFont { .italicSystemFont(ofSize: Sizes.huge.rawValue) }
    
    // MARK: - Regular
    static var tiny: UIFont { .systemFont(ofSize: Sizes.tiny.rawValue) }
    static var small: UIFont { .systemFont(ofSize: Sizes.small.rawValue) }
    static var regular: UIFont { .systemFont(ofSize: Sizes.regular.rawValue) }
    static var large: UIFont { .systemFont(ofSize: Sizes.large.rawValue) }
    static var huge: UIFont { .systemFont(ofSize: Sizes.huge.rawValue) }

}

public extension CGFloat {
    // MARK: - Padding
    /// 2.0 units
    static var tinyPadding: CGFloat { 2.0 }
    /// 4.0 units
    static var smallPadding: CGFloat { 4.0 }
    /// 8.0 units
    static var defaultPadding: CGFloat { 8.0 }
    /// 12.0 units
    static var largerDefaultPadding: CGFloat { 12.0 }
    /// 16.0 units
    static var bigPadding: CGFloat { 16.0 }
}
