//
//  CoordinatorTab_1.swift
//  Example of MVVM-C Pattern
//
//  Created by Marcello Chuahy on 18/02/20.
//  Copyright © 2020 Applause Codes. All rights reserved.
//

import UIKit

class PaymentsCentralCoordinator: NSObject, Coordinator {
  
  // MARK: - Coordinator Properties
  var childCoordinators = [Coordinator]()
  var navigationController: UINavigationController
  
    // MARK: - Instance Properties
  private var paymentsGroupedByType = PaymentsGroupedByType()
  private var summaryPayments = SummaryPayments(quantityOfDuePayments: 0,
                                        totalMonetaryValueOfDuePayments: 0,
                                        quantityOfOverduePayments: 0,
                                        totalMonetaryValueOfOverduePayments: 0,
                                        quantityOfExcludedPayments: 0,
                                        totalMonetaryValueOfExcludedPayments: 0)

  // MARK: - Instance Properties - ViewControllers
  // ==============================================================================================================================================
  private lazy var dashboardTVC      = DashboardTVC.instantiate(coordinator: self, summaryPayments: summaryPayments)
  private lazy var paymentListTVCs   = [
    PaymentListTVC.instantiate(coordinator: self, title: "pagamentos " + TypeOfPayment.duePayment.rawValue,      paymentsDataSource: paymentsGroupedByType.duePayment),
    PaymentListTVC.instantiate(coordinator: self, title: "pagamentos " + TypeOfPayment.overduePayment.rawValue,  paymentsDataSource: paymentsGroupedByType.overduePayment),
    PaymentListTVC.instantiate(coordinator: self, title: "pagamentos " + TypeOfPayment.excludedPayment.rawValue, paymentsDataSource: paymentsGroupedByType.excludedPayment)
  ]
  private lazy var proofOfPaymentTVC = ProofOfPaymentTVC()
  // ==============================================================================================================================================

  // MARK: - Initializers
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  // MARK: - Methods
  func start() {
    setupNavigationController()
    loadData()
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
    dashboardTVC.tabBarItem = UITabBarItem(title: "Central de Pagamentos", image: UIImage(named: "walletOutline"), selectedImage: UIImage(named: "walletFilled"))
    navigationController.viewControllers = [dashboardTVC]
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
            
            self.summaryPayments.quantityOfDuePayments                = json.quantityOfDuePayments
            self.summaryPayments.totalMonetaryValueOfDuePayments      = json.totalMonetaryValueOfDuePayments
            self.summaryPayments.quantityOfOverduePayments            = json.quantityOfOverduePayments
            self.summaryPayments.totalMonetaryValueOfOverduePayments  = json.totalMonetaryValueOfOverduePayments
            self.summaryPayments.quantityOfExcludedPayments           = json.quantityOfExcludedPayments
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
  func startDuePaymentsNavigation()      {
    navigationController.pushViewController(paymentListTVCs[0], animated: true)
    print("After DashboardDelegate => childCoordinators: \(childCoordinators)")
  }
  func startOverduePaymentsNavigation()  {
    navigationController.pushViewController(paymentListTVCs[1], animated: true)
    print("After DashboardDelegate => childCoordinators: \(childCoordinators)")
  }
  func startExcludedPaymentsNavigation() {
    navigationController.pushViewController(paymentListTVCs[2], animated: true)
    print("After DashboardDelegate => childCoordinators: \(childCoordinators)")
  }
}

extension PaymentsCentralCoordinator: PaymentListDelegate {
  
  func pay(monetaryValue: Double, forBeneficiary beneficiary: String) {
    
    let nextViewController = ProofOfPaymentTVC.instantiate(coordinator: self, monetaryValue: monetaryValue, beneficiary: beneficiary)
    navigationController.pushViewController(nextViewController, animated: true)
    print("After PaymentListDelegate => childCoordinators: \(childCoordinators)")
    
  }
  
}

extension PaymentsCentralCoordinator: ProofOfPaymentDelegate {
  func dismiss() {
    print("dismiss")
    // ... some code here ...
  }
}

extension PaymentsCentralCoordinator: UINavigationControllerDelegate {
  
  func navigationController(_ navigationController: UINavigationController,
                            didShow viewController: UIViewController, animated: Bool) {
    
    guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }
    
    if navigationController.viewControllers.contains(fromViewController) { return }
    
    if let paymentList = fromViewController as? PaymentListTVC {
      print("finish child coordinator of PaymentListTVC")
      childDidFinish(paymentList.coordinator as? Coordinator)
    }
    
    if let proofOfPayment = fromViewController as? ProofOfPaymentTVC {
      print("finish child coordinator of ProofOfPaymentTVC")
      childDidFinish(proofOfPayment.coordinator as? Coordinator)
    }

  }
  
}

