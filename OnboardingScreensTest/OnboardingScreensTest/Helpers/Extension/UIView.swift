//
//  UIView.swift
//  OnboardingScreensTest
//
//  Created by Illia Rahozin on 17.11.2023.
//

import UIKit

extension UIView {

    func addSubviews(_ views: UIView...) {
        views.forEach({addSubview($0)})
    }
    
}
