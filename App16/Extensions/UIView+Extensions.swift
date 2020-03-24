//
//  UIView+Extensions.swift
//  App16
//
//  Created by Grigor Aghabalyan on 3/25/20.
//  Copyright © 2020 X-TECH. All rights reserved.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    func fixInView(_ container: UIView) -> Void {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.frame = container.frame
        container.addSubview(self)
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
    
    func drawShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize = .zero, radius: CGFloat = 5, scale: Bool = true) {
        
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func bordered(lineWidth: CGFloat, strokeColor: UIColor = UIColor.white){
        let path = UIBezierPath.init(roundedRect: self.bounds, cornerRadius: self.frame.width/2)
        let borderLayer = CAShapeLayer()
        borderLayer.lineWidth = lineWidth
        borderLayer.strokeColor = strokeColor.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.frame = self.bounds
        borderLayer.path = path.cgPath
        self.layer.addSublayer(borderLayer)
    }
    
    func rounded(insets: UIEdgeInsets = .zero){
        let path = UIBezierPath.init(roundedRect: self.bounds.inset(by: insets), cornerRadius: self.frame.width/2)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
}
