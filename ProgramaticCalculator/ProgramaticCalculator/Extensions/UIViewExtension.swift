//
//  UIViewExtension.swift
//  Palette
//
//  Created by Ian Becker on 8/25/20.
//  Copyright © 2020 Cameron Stuart. All rights reserved.
//

import UIKit

extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor?, bottom: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingBottom: CGFloat, paddingLeading: CGFloat, paddingTrailing: CGFloat, width: CGFloat? = nil, height: CGFloat? = nil) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: paddingLeading).isActive = true
        }
        
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing, constant: -paddingTrailing).isActive = true
        }
        
        if let width = width {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
} // End of extension

struct SpacingConstants {
    static let verticalObjectBuffer: CGFloat = 8.0
    static let outerHorizontalPadding: CGFloat = 24.0
    static let outerVerticalPadding: CGFloat = 16.0
    static let oneLineElementHeight: CGFloat = 24.0
    static let twoLineElementHeight: CGFloat = 32.0
} // End of struct
