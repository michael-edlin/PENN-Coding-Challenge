//
//  InfoView.swift
//  PENN Code Challenge
//
//  Created by Tyler Edlin on 6/22/24.
//

import UIKit

class InfoView: UIView {
    
    private let titleLabel = UILabel()
    private let valueLabel = UILabel()
    private let adviceLabel = UILabel()
    private let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        // Gradient background
        gradientLayer.colors = [
            UIColor(red: 0.28, green: 0.47, blue: 0.8, alpha: 1).cgColor,
            UIColor(red: 0.22, green: 0.39, blue: 0.72, alpha: 1).cgColor
        ]
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.cornerRadius = 12
        layer.insertSublayer(gradientLayer, at: 0)
        
        // Title Label
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        // Value Label
        valueLabel.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        valueLabel.textColor = .white
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(valueLabel)
        
        // Advice Label
        adviceLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        adviceLabel.textColor = .white
        adviceLabel.numberOfLines = 0
        adviceLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(adviceLabel)
        
        // Constraints
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            valueLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            adviceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            adviceLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            adviceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            adviceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    func configure(title: String, value: String, advice: String) {
        titleLabel.text = title
        valueLabel.text = value
        adviceLabel.text = advice
    }
}
