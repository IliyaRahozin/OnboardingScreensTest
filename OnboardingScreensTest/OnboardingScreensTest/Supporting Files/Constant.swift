//
//  Constant.swift
//  OnboardingScreensTest
//
//  Created by Illia Rahozin on 17.11.2023.
//

import UIKit

class Constant {
    static let background      = UIImage(named: "Background")
    static let activeControl   = UIImage(named: "active_page")
    static let inactiveControl = UIImage(named: "inactive_page")
    
    enum Hyperlink {
        
        case terms
        case privacyPolicy
        case subscriptionTerms

        var displayText: String {
            switch self {
            case .terms: return "Terms"
            case .privacyPolicy: return "Privacy Policy"
            case .subscriptionTerms: return "Subscription Terms"
            }
        }

        var urlString: String {
            switch self {
            case .terms: return "https://yourtermsurl.com"
            case .privacyPolicy: return "https://yourprivacypolicyurl.com"
            case .subscriptionTerms: return "https://yoursubscriptiontermsurl.com"
            }
        }
        
        static func formattedText() -> String {
            return "By continuing, you agree to our:\n \(Constant.Hyperlink.terms.displayText) and \(Constant.Hyperlink.privacyPolicy.displayText) found and \(Constant.Hyperlink.subscriptionTerms.displayText)"
        }
        
        var hyperLink: HyperlinkType {
            return HyperlinkType(displayText: self.displayText, urlString: self.urlString)
        }
        
        static func allLinks() -> [HyperlinkType] {
            return [
                        Hyperlink.terms.hyperLink,
                        Hyperlink.privacyPolicy.hyperLink,
                        Hyperlink.subscriptionTerms.hyperLink
                    ]
        }
        
    }
    
}
