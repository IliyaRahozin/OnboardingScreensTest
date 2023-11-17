//
//  OnboardingPageViewModel.swift
//  OnboardingScreensTest
//
//  Created by Illia Rahozin on 17.11.2023.
//

import Foundation
import RxSwift

protocol OnboardingPageListViewModelType {
    var currentPageIndex: Int { get set }
    func numberOfSections() -> Int
    func numberOfItemInSection(in section: Int) -> Int
    func getPageForRow(at indexPath: IndexPath) -> OnboardingPageViewModel
}

struct OnboardingPageListViewModel: OnboardingPageListViewModelType {

    var currentPageIndex: Int

    private var onboardingPagesViewModel: [OnboardingPageViewModel]

    init(_ pages: [OnboardingPage]) {
        self.currentPageIndex = 0
        self.onboardingPagesViewModel = OnboardingPage.allCases.compactMap(OnboardingPageViewModel.init)
    }
        
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItemInSection(in section: Int = 1) -> Int {
        return onboardingPagesViewModel.count
    }
    
    func getPageForRow(at indexPath: IndexPath) -> OnboardingPageViewModel {
        return onboardingPagesViewModel[indexPath.row]
    }
}


struct OnboardingPageViewModel {
    
    private(set) var page: OnboardingPage

    init(_ page: OnboardingPage) {
        self.page = page
    }
    
    var pageImage: Observable<UIImage?> {
        let image = page.illustration
        return Observable<UIImage?>.just(image)
    }
    
    var pageTitle: Observable<String> {
        return Observable<String>.just(page.title)
    }
    
    var pageDescription: Observable<String> {
        let description = "\(page.description)"
        return Observable<String>.just(description)
    }
    
}
