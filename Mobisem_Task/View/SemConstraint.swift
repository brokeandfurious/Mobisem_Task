
//  SemConstraint.swift
//  Mobisem_Task
//
//  Created by mkolcalar on 29.03.2018.
//  Copyright © 2018 murtilicious. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func arrangeConstraints(_ left: NSLayoutXAxisAnchor?=nil, leftConstant: CGFloat?=nil,
                            right: NSLayoutXAxisAnchor?=nil, rightConstant: CGFloat?=nil,
                            top: NSLayoutYAxisAnchor?=nil, topConstant: CGFloat?=nil,
                            bottom: NSLayoutYAxisAnchor?=nil, bottomConstant: CGFloat?=nil,
                            width: NSLayoutDimension?=nil, widthMultiplier: CGFloat?=nil, widthConstant: CGFloat?=nil, wEqualToConstant: CGFloat?=nil,
                            height: NSLayoutDimension?=nil, heightMultiplier: CGFloat?=nil, heightConstant: CGFloat?=nil, hEqualToConstant: CGFloat?=nil,
                            centerX: NSLayoutXAxisAnchor?=nil, centerY: NSLayoutYAxisAnchor?=nil) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let left = left, let leftConstant = leftConstant {
            self.leftAnchor.constraint(equalTo: left, constant: leftConstant).isActive = true
        }
        
        if let right = right, let rightConstant = rightConstant {
            self.rightAnchor.constraint(equalTo: right, constant: rightConstant).isActive = true
        }
        
        if let top = top, let topConstant = topConstant {
            self.topAnchor.constraint(equalTo: top, constant: topConstant).isActive = true
        }
        
        if let bottom = bottom, let bottomConstant = bottomConstant {
            self.bottomAnchor.constraint(equalTo: bottom, constant: bottomConstant).isActive = true
        }
        
        if let width = width, let widthConstant = widthConstant, let widthMultiplier = widthMultiplier {
            self.widthAnchor.constraint(equalTo: width, multiplier: widthMultiplier, constant: widthConstant).isActive = true
        }
        
        if let height = height, let heightConstant = heightConstant, let heightMultiplier = heightMultiplier {
            self.heightAnchor.constraint(equalTo: height, multiplier: heightMultiplier, constant: heightConstant).isActive = true
        }
        
        if let wEqualToConstant = wEqualToConstant {
            self.widthAnchor.constraint(equalToConstant: wEqualToConstant).isActive = true
        }
        
        if let hEqualToConstant = hEqualToConstant {
            self.heightAnchor.constraint(equalToConstant: hEqualToConstant).isActive = true
        }
        
        if let centerX = centerX {
            self.centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        
        if let centerY = centerY {
            self.centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
    }
    
}
