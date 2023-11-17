//
//  OnboardingPageControllerView.swift
//  OnboardingScreensTest
//
//  Created by Illia Rahozin on 17.11.2023.
//

import UIKit

class OnboardinPageControllerView: UIView {
    
    private var onboardingPageListViewModel = OnboardingPageListViewModel([])
    
    lazy var continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(.continueButtonText, for: .normal)
        button.backgroundColor = .continueButton
        button.layer.cornerRadius = 28
        
        return button
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.numberOfPages = onboardingPageListViewModel.numberOfItemInSection()
        pageControl.currentPageIndicatorTintColor = .activePage
        pageControl.pageIndicatorTintColor = .inactivePage
        if #available(iOS 14.0, *) {
            pageControl.preferredIndicatorImage = Constant.inactiveControl
            // pageControl.preferredCurrentPageIndicatorImage = Constant.activeControl
        } else {
            // Fallback on earlier versions
        }
        pageControl.backgroundColor = .clear

        return pageControl
    }()
    
    private lazy var termsTextView: UITextView = {
        let textView = UITextView()
        textView.textAlignment = .center
        textView.backgroundColor = .clear
        textView.textContainer.maximumNumberOfLines = 2
        textView.isEditable = false
        textView.textColor = .termsText
        textView.attributedText = NSMutableAttributedString(string: Constant.Hyperlink.formattedText())

        return textView
    }()
    
    init(viewModel: OnboardingPageListViewModel) {
        self.onboardingPageListViewModel = viewModel
        super.init(frame: .zero)
        setupViews()
        setupHyperLinks()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHyperLinks() {
        let hyperlinks = Constant.Hyperlink.allLinks()
        termsTextView.setAttributedText(with: hyperlinks, defaultColor: .termsText, linkColor: .hyperLinks)
    }
    
    
    private func setupViews() {
        self.addSubviews(
            continueButton,
            termsTextView,
            pageControl
        )
        
        continueButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(56)
        }
        
        termsTextView.snp.makeConstraints { make in
            make.top.equalTo(continueButton.snp.bottom)
            make.left.right.equalTo(continueButton)
            make.bottom.equalToSuperview()
        }
        
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(continueButton.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(20)
            make.bottom.equalToSuperview().inset(15)
        }
        
        pageControl.isHidden = true
        termsTextView.isHidden = false
    }
    
}

extension OnboardinPageControllerView {
    
    func updateControllerPosition(index: Int) {
        self.pageControl.currentPage = index
        self.updateViews()
    }
    
    private func updateViews() {
        if pageControl.currentPage == 0 || pageControl.currentPage == onboardingPageListViewModel.numberOfItemInSection() - 1
        {
            termsTextView.isHidden = false
            pageControl.isHidden = true
            setButtonTitleForLastPage()
        } else {
            termsTextView.isHidden = true
            pageControl.isHidden = false
            setButtonTitleForLastPage()
        }
    }
    
    private func setButtonTitleForLastPage() {
        if pageControl.currentPage == onboardingPageListViewModel.numberOfItemInSection() - 1 {
            continueButton.setTitle("Try Free & Subscribe", for: .normal)
        } else {
            continueButton.setTitle("Continue", for: .normal)
        }
    }

}
