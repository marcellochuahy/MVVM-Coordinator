//
//  CoordinatorTab_1.swift
//  Example4-MVVM-to-MVVMC
//
//  Created by Marcello Chuahy on 18/02/20.
//  Copyright © 2020 Applause Codes. All rights reserved.
//

import UIKit

class PaymentsCentralCoordinator: NSObject, Coordinator {
  
  // MARK: - Properties
  var childCoordinators = [Coordinator]()
  var navigationController: UINavigationController
  var paymentsGroupedByType = PaymentsGroupedByType()
  var summaryPayments = SummaryPayments(quantityOfDuePayments: 0,
                                        totalMonetaryValueOfDuePayments: 0,
                                        quantityOfOverduePayments: 0,
                                        totalMonetaryValueOfOverduePayments: 0,
                                        quantityOfExcludedPayments: 0,
                                        totalMonetaryValueOfExcludedPayments: 0)

  // MARK: - Instance Properties - ViewControllers
  /// Create customized versions of ListTableTVC
  private lazy var paymentListTableViewControllers = [
    PaymentListTVC.instantiate(delegate: self, title: TypeOfPayment.duePayment.rawValue),
    PaymentListTVC.instantiate(delegate: self, title: TypeOfPayment.overduePayment.rawValue),
    PaymentListTVC.instantiate(delegate: self, title: TypeOfPayment.excludedPayment.rawValue)
  ]

  // MARK: - Initializers
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  // MARK: - Methods
  func start() {
    setupNavigationController()
    loadData()
  }
  func setupNavigationController() {
    
    let viewController = DashboardTVC.instantiate(coordinator: self, summaryPayments: summaryPayments)
    
    viewController.tabBarItem = UITabBarItem(title: "Central de Pagamentos",
                                             image: UIImage(named: "walletOutline"),
                                             selectedImage: UIImage(named: "walletFilled"))
    
    //navigationController.pushViewController(viewController, animated: false)
    
    navigationController.viewControllers = [viewController]
    navigationController.delegate = self
  }
  func loadData() {
    
    guard let url = Bundle.main.url(forResource: "webServicePagamentos", withExtension: "json") else {
      return
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
      
      if let data = data {
        
        do {
          
          let json = try JSONDecoder().decode(WebServiceDecoder.self, from: data)
          
          let statusCode = json.statusCode
          
          if statusCode == 200 {
            
            self.paymentsGroupedByType.duePayment      = json.duePayment
            self.paymentsGroupedByType.overduePayment  = json.overduePayment
            self.paymentsGroupedByType.excludedPayment = json.excludedPayment
            
            self.summaryPayments.quantityOfDuePayments               = json.quantityOfDuePayments
            self.summaryPayments.totalMonetaryValueOfDuePayments      = json.totalMonetaryValueOfDuePayments
            self.summaryPayments.quantityOfOverduePayments           = json.quantityOfOverduePayments
            self.summaryPayments.totalMonetaryValueOfOverduePayments  = json.totalMonetaryValueOfOverduePayments
            self.summaryPayments.quantityOfExcludedPayments          = json.quantityOfExcludedPayments
            self.summaryPayments.totalMonetaryValueOfExcludedPayments = json.totalMonetaryValueOfExcludedPayments
            
            
          } else {
            print("Error to conect API 😤")
          }
          
          DispatchQueue.main.async { [weak self] in
            
            guard let summaryPayments = self?.summaryPayments else { return }
            
            let viewController = DashboardTVC.instantiate(coordinator: self, summaryPayments: summaryPayments)
            
            viewController.tabBarItem = UITabBarItem(title: "tab1",
                                                     image: UIImage(named: "walletOutline"),
                                                     selectedImage: UIImage(named: "walletFilled"))
            
            self?.navigationController.viewControllers = [viewController]
            self?.navigationController.delegate = self
            
            
          }
          
        } catch let error {
          print(error)
        }
        
      }
      
    }.resume()
    
  }
  
}

extension PaymentsCentralCoordinator: DashboardDelegate {
  
  func startDuePaymentsNavigation() {
    
    let paymentsDataSource = paymentsGroupedByType.duePayment
    print("A")
    //    let child = CoordinatorTab_1_pagamentosAVencer(navigationController: navigationController,
    //                                  paymentsDataSource: paymentsGroupedByType.duePayment)
    //        childCoordinators.append(child)
    //        child.parentCoordinator = self
    //        child.start()
  }
  
  func startOverduePaymentsNavigation() {
    print("B")
    //    let child = CoordinatorTab_1_pagamentosVencidos(navigationController: navigationController,
    //                                  paymentsDataSource: paymentsGroupedByType.overduePayment)
    //        childCoordinators.append(child)
    //        child.parentCoordinator = self
    //        child.start()
  }
  
  func startExcludedPaymentsNavigation() {
    print("C")
    //    let child = CoordinatorTab_1_pagamentosExcluidos(navigationController: navigationController,
    //                                  paymentsDataSource: paymentsGroupedByType.excludedPayment)
    //        childCoordinators.append(child)
    //        child.parentCoordinator = self
    //        child.start()
  }
  
}

extension PaymentsCentralCoordinator: PaymentListDelegate {
  
  func pagarBoleto(indexPath: IndexPath) {
    print("PaymentListDelegate")
  }
 
}

extension PaymentsCentralCoordinator: UINavigationControllerDelegate {
  
  func navigationController(_ navigationController: UINavigationController,
                            didShow viewController: UIViewController, animated: Bool) {
    
    guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }
    
    if navigationController.viewControllers.contains(fromViewController) { return }
    
    //        if let viewController1A = fromViewController as? ViewController1A {
    //            childDidFinish(viewController1A.coordinator as? Coordinator)
    //        }
    
    //        if let viewController2A = fromViewController as? ViewController2A {
    //            childDidFinish(viewController2A.coordinator)
    //        }
    
  }
  
}

