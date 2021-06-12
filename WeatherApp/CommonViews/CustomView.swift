//
//  CustomView.swift
//  WeatherApp
//
//  Created by Abhisek K. on 12/06/21.
//

import Foundation
import UIKit

@IBDesignable
class CustomView: UIView {
    
    // MARK: - RADIUS
    @IBInspectable var radiusFixed: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = self.radiusFixed
        }
    }
    
    @IBInspectable var radiusVariable: CGFloat = 0.0 {
        didSet {
//            self.radiusVariable = GlobalUtil.getVariableCornerRadius(radius: self.radiusVariable);
            self.layer.cornerRadius = self.radiusVariable
        }
    }
    // MARK: - BORDER
    @IBInspectable var borderFixed: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = self.borderFixed
        }
    }
    
    @IBInspectable var borderVariable: CGFloat = 0.0 {
        didSet {
            
//            self.borderVariable = GlobalUtil.getVariableBorderWidth(border: self.borderVariable);
            self.layer.borderWidth = self.borderVariable
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.black {
        didSet {
            self.layer.borderColor = self.borderColor.cgColor
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet {
            self.addShadow()
        }
    }
    
    @IBInspectable var shadowColor: UIColor = UIColor.gray{
        didSet {
            self.addShadow()
        }
    }
    
    @IBInspectable var shadowOpacity: CGFloat = 0 {
        didSet {
            self.addShadow()
        }
    }
    
    @IBInspectable var shadowWidth: CGFloat = 0{
        didSet{
            self.addShadow()
        }
    }
    @IBInspectable var shadowHeight: CGFloat = 0{
        didSet{
            self.addShadow()
        }
    }
    
   override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func addShadow(){
//        addShadow(offset: CGSize.init(width: shadowWidth, height: shadowHeight), color: shadowColor, radius: shadowRadius, opacity: shadowOpacity)
    }
 }
