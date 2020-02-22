//
//  CoordinatorTab_1.swift
//  Example4-MVVM-to-MVVMC
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
  private lazy var beneficiary       = ""
  private lazy var monetaryValue     = 0.00
  private lazy var dashboardTVC      = DashboardTVC.instantiate(coordinator: self, summaryPayments: summaryPayments)
  private lazy var paymentListTVCs   = [
    PaymentListTVC.instantiate(coordinator: self, title: "pagamentos " + TypeOfPayment.duePayment.rawValue,      paymentsDataSource: paymentsGroupedByType.duePayment),
    PaymentListTVC.instantiate(coordinator: self, title: "pagamentos " + TypeOfPayment.overduePayment.rawValue,  paymentsDataSource: paymentsGroupedByType.overduePayment),
    PaymentListTVC.instantiate(coordinator: self, title: "pagamentos " + TypeOfPayment.excludedPayment.rawValue, paymentsDataSource: paymentsGroupedByType.excludedPayment)
  ]
  private lazy var proofOfPaymentTVC = ProofOfPaymentTVC.instantiate(coordinator: self, beneficiary: beneficiary, monetaryValue: monetaryValue)

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
  func startDuePaymentsNavigation()      { navigationController.pushViewController(paymentListTVCs[0], animated: true) }
  func startOverduePaymentsNavigation()  { navigationController.pushViewController(paymentListTVCs[1], animated: true) }
  func startExcludedPaymentsNavigation() { navigationController.pushViewController(paymentListTVCs[2], animated: true) }
}

extension PaymentsCentralCoordinator: PaymentListDelegate {
  func pay(monetaryValue: Double, forBeneficiary beneficiary: String) {
    
    self.monetaryValue = monetaryValue
    self.beneficiary   = beneficiary
    

    navigationController.pushViewController(proofOfPaymentTVC, animated: true)
    
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
    
    //        if let viewController1A = fromViewController as? ViewController1A {
    //            childDidFinish(viewController1A.coordinator as? Coordinator)
    //        }
    
    //        if let viewController2A = fromViewController as? ViewController2A {
    //            childDidFinish(viewController2A.coordinator)
    //        }
    
  }
  
}

