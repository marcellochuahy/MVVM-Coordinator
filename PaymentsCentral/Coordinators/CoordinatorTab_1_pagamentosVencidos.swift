//
//  CoordinatorTab_1B.swift
//  Example4-MVVM-to-MVVMC
//
//  Created by Marcello Chuahy on 18/02/20.
//  Copyright © 2020 Applause Codes. All rights reserved.
//

//import UIKit
//
//class CoordinatorTab_1_pagamentosVencidos: Coordinator {
//  
//  var childCoordinators = [Coordinator]()
//  var navigationController: UINavigationController
//  var paymentsDataSource: [DayAndPayments]?
//  
//  weak var parentCoordinator: PaymentsCentralCoordinator?
//  
//  init(navigationController: UINavigationController, paymentsDataSource: [DayAndPayments]?) {
//    self.navigationController = navigationController
//    self.paymentsDataSource = paymentsDataSource
//  }
//  
//  func start() {
//    let viewController = PaymentListTVC.instantiate(delegate: self,
//                                                       tipoDePagamento: .pagamentosVencidos,
//                                                       paymentsDataSource: paymentsDataSource)
//    viewController.coordinator = self
//    navigationController.pushViewController(viewController, animated: true)
//  }
//  
//}
//
//
//extension CoordinatorTab_1_pagamentosVencidos: ListaDePagamentosDelegate {
//  
//  func pagarBoleto(indexPath: IndexPath) {
//    
//    guard let key = paymentsDataSource?[indexPath.section]?.keys.first,
//          let todosOsPagamentos = paymentsDataSource?[indexPath.section],
//          let pagamentosPorDiaSelecionado = todosOsPagamentos[key] else { return }
//    
//    let pagamentoSelecionado = pagamentosPorDiaSelecionado[indexPath.row]
//    let beneficiary = pagamentoSelecionado.beneficiary
//    let monetaryValue  = pagamentoSelecionado.monetaryValue
//    
//    navigateToComprovanteDePagamento(withBeneficiario: beneficiary, andValorAPagar: monetaryValue)
//
//  }
//
//  private func navigateToComprovanteDePagamento(withBeneficiario beneficiary: String, andValorAPagar monetaryValue: Double) {
//    let viewController = ComprovanteDePagamento.instantiate(delegate: self, beneficiary: beneficiary, monetaryValue: monetaryValue)
//        navigationController.pushViewController(viewController, animated: true)
//  }
//  
//}
//
//extension CoordinatorTab_1_pagamentosVencidos: ComprovanteDePagamentoDelegate {
//  func dismiss() {
//    //
//  }
//}
//
