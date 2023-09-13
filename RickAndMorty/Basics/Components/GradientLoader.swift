//
//  GradientLoader.swift
//  RickAndMorty
//
//  Created by Pavel on 28.08.2023.
//

import UIKit

class GradientLoader: CAGradientLayer {
    
    //MARK: - Properties
    
    private var superview: UIView
    private let gradientLayer = CAGradientLayer()
    
    //MARK: - Init
    
    init(superview: UIView) {
        self.superview = superview
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    func startGradientAnimation(firstColor: CGColor? = nil, secondColor: CGColor? = nil) {
        let mainColor = firstColor ?? superview.backgroundColor?.cgColor
        let highlightColor = secondColor ?? CustomColor.white?.cgColor
        guard let mainColor, let highlightColor else { return }
        gradientLayer.frame = superview.bounds
        
        if superview.layer.cornerRadius == 0 {
            gradientLayer.cornerRadius = gradientLayer.bounds.height/2
        } else {
            gradientLayer.cornerRadius = superview.layer.cornerRadius
        }
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = [mainColor, highlightColor, mainColor]
        gradientLayer.locations = [-1, 1]
        let animation = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.locations))
        animation.fromValue = [-3.0, -2.0, -1.0]
        animation.toValue = [1.0, 2.0, 8.0]
        animation.duration = 2.0
        animation.autoreverses = false
        animation.repeatCount = .infinity
        gradientLayer.add(animation, forKey: nil)
        superview.layer.addSublayer(gradientLayer)
    }
    
    func stopGradientAnimation() {
        gradientLayer.removeFromSuperlayer()
    }
}
