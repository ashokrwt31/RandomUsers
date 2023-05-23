//
//  CustomAgeView.swift
//  RandomUsers
//
//  Created by Ashok Rawat on 23/05/23.
//

import Foundation

public class CustomAgeView: UIView {
     var ageLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViewBorder()
        setUpLabel()
        rotate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setViewBorder()
        setUpLabel()
        rotate()
    }
    
    private func setViewBorder() {
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.orange.cgColor
    }
    
    private func setUpLabel() {
        ageLabel = UILabel()
        ageLabel.textAlignment = .center
        ageLabel.textColor = .white
        ageLabel.font = .boldSystemFont(ofSize: 16)
        addSubview(ageLabel)
        ageLabel.frame = bounds
    }
    
    private func rotate() {
        let rotateAngle: CGFloat = Double.pi / 4.0
        transform = CGAffineTransform(rotationAngle: rotateAngle)
        ageLabel.transform = CGAffineTransform(rotationAngle: -rotateAngle)
    }
}
