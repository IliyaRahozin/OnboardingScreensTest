//
//  OnboardingPage.swift
//  OnboardingScreensTest
//
//  Created by Illia Rahozin on 17.11.2023.
//

import UIKit

enum OnboardingPage: CaseIterable {

    case pageZero
    case pageOne
    case pageTwo
    case pageThree

    var title: String {
        switch self {
        case .pageZero:
            return "Your Personal\nAssistant"

        case .pageOne:
            return "Get assistance\nwith any topic"

        case .pageTwo:
            return "Perfect copy\nyou can rely on"
            
        case .pageThree:
            return "Upgrade for Unlimited\nAI Capabilities"
        }
    }
    
    var description: String {
        switch self {
        case .pageZero:
            return "Simplify your life\nwith an AI companion"
            
        case .pageOne:
            return "From daily tasks to complex\nqueries, we’ve got you covered"
            
        case .pageTwo:
            return "Generate professional\n texts effortlessly"
            
        case .pageThree:
            return "7-Day Free Trial,\n then $19.99/month, auto-renewable"
        }
    }

    var illustration: UIImage? {
        switch self {
        case .pageZero:
            return UIImage(named: "page0_llustration")

        case .pageOne:
            return UIImage(named: "page1_llustration")

        case .pageTwo:
            return UIImage(named: "page2_llustration")
                           
        case .pageThree:
            return UIImage(named: "page3_llustration")
        }
    }

    var index: Int {
        switch self {
        case .pageZero:
            return 0

        case .pageOne:
            return 1

        case .pageTwo:
            return 2

        case .pageThree:
            return 3
        }
    }

}
