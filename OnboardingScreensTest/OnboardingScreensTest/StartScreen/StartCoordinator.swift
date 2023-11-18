//
//  StartCoordinator.swift
//  OnboardingScreensTest
//
//  Created by Illia Rahozin on 18.11.2023.
//

import Foundation

import UIKit

class StartCoordinator: Coordinator {
    
    weak var parentCoordinator: MainCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
           
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = StartViewController()
        viewController.coordinator = self
        navigationController.push(viewController: viewController)
    }
    
    func showOnboarding() {
        parentCoordinator?.navigateToOnboardingViewController()
    }
    
    func presentButtonTapped() {
        
    }
    
}
