//
//  OnboardingCoordinator.swift
//  OnboardingScreensTest
//
//  Created by Illia Rahozin on 17.11.2023.
//

import UIKit

class OnboardingCoordinator: Coordinator {
    
    weak var parentCoordinator: MainCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = OnboardingCollectionViewController(pagesData: OnboardingPage.allCases)
        viewController.coordinator = self
        navigationController.push(viewController: viewController)
    }
    
    func close() {
        if let start = parentCoordinator?.childCoordinators.first(where: { $0 is StartCoordinator }) as? StartCoordinator {
            parentCoordinator?.childCoordinators.removeLast()
            navigationController.pop()
        } else {
            parentCoordinator?.navigateToStartViewController()
        }
    }
    
}
