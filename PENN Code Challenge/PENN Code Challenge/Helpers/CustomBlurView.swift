//
//  CustomBlurView.swift
//  PENN Code Challenge
//
//  Created by Michael Edlin on 06/23/24.
//


import UIKit

@IBDesignable
class CustomBlurView: UIVisualEffectView {
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.cornerCurve = .continuous
            layer.masksToBounds = true
        }
    }
}
