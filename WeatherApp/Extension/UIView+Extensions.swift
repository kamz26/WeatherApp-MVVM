//
//  UIView+Extensions.swift
//  WeatherApp
//
//  Created by Abhisek K. on 12/06/21.
//

import Foundation
import UIKit


extension UIView {

    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: CGFloat) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = Float(opacity)

        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
}
