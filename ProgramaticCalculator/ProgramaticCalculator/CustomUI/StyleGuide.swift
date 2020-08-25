//
//  StyleGuide.swift
//  TipCalc35
//
//  Created by Ian Becker on 8/24/20.
//  Copyright © 2020 Colton Swapp. All rights reserved.
//

import UIKit

extension UIView {

func addCornerRadius(_ radius: CGFloat = 4) {
    self.layer.cornerRadius = radius
    }
}

extension UIColor {
    
    static let darkBlue = UIColor(named: "darkBlue")
    static let customGreen = UIColor(named: "green")
    static let headerGray = UIColor(named: "headerGray")
}
