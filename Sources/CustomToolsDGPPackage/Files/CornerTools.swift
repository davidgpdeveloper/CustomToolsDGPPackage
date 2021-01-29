//
//  CornerTools.swift
//  CustomToolsDGP
//
//  Created by David Galán on 20/07/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//

import UIKit

extension UIView {
    
    public func roundSpecificsCorners(corners: UIRectCorner, radius: CGFloat, clipsToBoundsValue: Bool = true) {
        if #available(iOS 11.0, *) {
            clipsToBounds = clipsToBoundsValue
            layer.cornerRadius = radius
            layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
        } else {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
    
    public func setRoundView() {
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
}
