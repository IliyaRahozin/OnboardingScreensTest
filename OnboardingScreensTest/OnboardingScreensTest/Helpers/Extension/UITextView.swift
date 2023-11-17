//
//  UITextField.swift
//  OnboardingScreensTest
//
//  Created by Illia Rahozin on 17.11.2023.
//

import UIKit

struct HyperlinkType {
    let displayText: String
    let urlString: String
}

extension UITextView {
    func setAttributedText(with hyperlinks: [HyperlinkType], defaultColor: UIColor, linkColor: UIColor) {
        let style = NSMutableParagraphStyle()
        style.alignment = .center

        let attributedText = NSMutableAttributedString(string: self.text)

        for hyperlink in hyperlinks {
            let linkRange = attributedText.mutableString.range(of: hyperlink.displayText)
            let fullRange = NSMakeRange(0, attributedText.length)

            attributedText.addAttribute(NSAttributedString.Key.link, value: hyperlink.urlString, range: linkRange)
            attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: fullRange)
            attributedText.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 11), range: fullRange)
            attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: defaultColor, range: fullRange)
            attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: linkColor, range: linkRange)
        }

        self.linkTextAttributes = [
            NSAttributedString.Key.foregroundColor: linkColor,
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        self.attributedText = attributedText
    }
}
