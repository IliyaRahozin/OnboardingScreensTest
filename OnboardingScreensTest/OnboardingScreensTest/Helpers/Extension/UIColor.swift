//
//  UIColor.swift
//  OnboardingScreensTest
//
//  Created by Illia Rahozin on 17.11.2023.
//

import UIKit

extension UIColor {
    
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: alpha)
    }
    
    // MARK: - PageCollectionCell
    static let backgroundPage     = UIColor.rgb(r: 4, g: 91, b: 154, alpha: 0.24)
    static let titleText          = UIColor.rgb(r: 255, g: 255, b: 255)
    static let descriptionText    = UIColor.rgb(r: 227, g: 227, b: 227)
    
    static let continueButton     = UIColor.rgb(r: 255, g: 255, b: 255)
    static let continueButtonText = UIColor.rgb(r: 25, g: 31, b: 40)
    
    // MARK: - NavBarItems
    static let restorePurchase    = UIColor.rgb(r: 144, g: 153, b: 166)
    static let closeButton        = UIColor.rgb(r: 255, g: 255, b: 255, alpha: 0.6)
    
    // MARK: - PageControl
    static let activePage         =  UIColor.rgb(r: 0, g: 154, b: 255)
    static let inactivePage       =  UIColor.rgb(r: 144, g: 153, b: 166)
    
    // MARK: - Terms
    static let termsText          = UIColor.rgb(r: 110, g: 110, b: 115)
    static let hyperLinks         = UIColor.rgb(r: 32, g: 139, b: 255)
    

}
