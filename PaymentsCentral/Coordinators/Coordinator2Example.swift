//
//  Coordinator2Example.swift
//  PaymentsCentral
//
//  Created by Marcello Chuahy on 23/02/20.
//  Copyright © 2020 Applause Codes. All rights reserved.
//

import UIKit

class Coordinator2Example: NSObject, Coordinator {
  
  // MARK: - Coordinator Properties
  var childCoordinators = [Coordinator]()
  var navigationController: UINavigationController
  
  
  // MARK: - Instance Properties - ViewControllers
  // =============================================
  
  
  
  
  
  
  
  // =============================================
  
  // MARK: - Initializers
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  // MARK: - Methods
  func start() {
    setupNavigationController()
  }
  
  func childDidFinish(_ child: Coordinator?) {
    for (index, coordinator) in childCoordinators.enumerated() {
      if coordinator === child {
        childCoordinators.remove(at: index)
        print("After childDidFinish => childCoordinators: \(childCoordinators)")
        break
      } else {
        print("After childDidFinish => there nothing to remove")
      }
    }
  }
  
  func setupNavigationController() {
    // TODO
//    dashboardTVC.tabBarItem = UITabBarItem(title: "TAB2", image: UIImage(named: "walletOutline"), selectedImage: UIImage(named: "walletFilled"))
//    navigationController.viewControllers = [dashboardTVC]
//    navigationController.delegate = self
  }

  
}


extension Coordinator2Example: UINavigationControllerDelegate {
  
  func navigationController(_ navigationController: UINavigationController,
                            didShow viewController: UIViewController, animated: Bool) {
    
    guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }
    
    if navigationController.viewControllers.contains(fromViewController) { return }
    

    
  }
  
}
