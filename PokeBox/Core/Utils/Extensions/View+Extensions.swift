//
//  View+Extensions.swift
//  PokeBox
//
//  Created by Enygma System on 27/04/22.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadiusV: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidthV: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColorV: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    func dropShadow(scale: Bool = true) {
      self.layer.masksToBounds = false
      self.layer.shadowColor = UIColor.darkGray.cgColor
      self.layer.shadowOpacity = 0.2
      self.layer.shadowOffset = CGSize(width: 0, height: 2)
      self.layer.shadowRadius = 8

//      self.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
      self.layer.shouldRasterize = true
      self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
//        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    enum Visibility {
        case visible
        case invisible
        case gone
    }
    
    var visibility: Visibility {
        get {
            let constraint = (self.constraints.filter {$0.firstAttribute == .height && $0.constant == 0}.first)
            if let constraint = constraint, constraint.isActive {
                return .gone
            } else {
                return self.isHidden ? .invisible : .visible
            }
        }
        set {
            if self.visibility != newValue {
                self.setVisibility(newValue)
            }
        }
    }
    
    private func setVisibility(_ visibility: Visibility) {
        let constraint = (self.constraints.filter {$0.firstAttribute == .height && $0.constant == 0}.first)
        
        switch visibility {
        case .visible:
            constraint?.isActive = false
            self.isHidden = false
        case .invisible:
            constraint?.isActive = false
            self.isHidden = true
        case .gone:
            if let constraint = constraint {
                constraint.isActive = true
            } else {
                let constraint = NSLayoutConstraint(
                    item: self,
                    attribute: .height,
                    relatedBy: .equal,
                    toItem: nil,
                    attribute: .height,
                    multiplier: 1,
                    constant: 0)
                self.addConstraint(constraint)
                constraint.isActive = true
            }
        }
    }
}
