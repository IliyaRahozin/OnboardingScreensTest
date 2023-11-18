//
//  MainCoordinator.swift
//  OnboardingScreensTest
//
//  Created by Illia Rahozin on 17.11.2023.
//

import UIKit

class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        navigateToOnboardingViewController()
    }
    
    func navigateToOnboardingViewController() {
        let child = OnboardingCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
        
    func navigateToStartViewController() {
        popCoordinator(childCoordinators.first)
        let child = StartCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    func popCoordinator(_ coordinator: Coordinator?) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
            navigationController.viewControllers.remove(at: index)
        }
    }
    
}
