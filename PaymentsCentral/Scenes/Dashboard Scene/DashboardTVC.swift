//
//  CentralDePagamentos.swift
//  Example2-MVC-ViewCode
//
//  Created by Marcello Chuahy on 16/02/20.
//  Copyright © 2020 Applause Codes. All rights reserved.
//

import UIKit

public protocol DashboardDelegate: class {
  func startDuePaymentsNavigation()
  func startOverduePaymentsNavigation()
  func startExcludedPaymentsNavigation()
}

class DashboardTVC: UITableViewController {
  
  // ⚠️
  // MARK: Properties
  weak var coordinator: DashboardDelegate?
  
//  var pagamentosAVencerQtd: Int?
//  var pagamentosAVencerTotalAPagar: Double?
//  var pagamentosVencidosQtd: Int?
//  var pagamentosVencidosTotalAPagar: Double?
//  var pagamentosExcluidosQtd: Int?
//  var pagamentosExcluidosTotalAPagar: Double?
  
  var summaryPayments = SummaryPayments(quantityOfDuePayments: 0,
                                        totalMonetaryValueOfDuePayments: 0,
                                        quantityOfOverduePayments: 0,
                                        totalMonetaryValueOfOverduePayments: 0,
                                        quantityOfExcludedPayments: 0,
                                        totalMonetaryValueOfExcludedPayments: 0)
  
  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
  }
  
  func setupTableView() {
    tableView.backgroundColor = UIColor.CustomStyle.backgroundGray
    tableView.separatorStyle = .none
    tableView.register(DashboardTVCell.self, forCellReuseIdentifier: "cell")
  }
  
}

// MARK: - Constructors
extension DashboardTVC {
  
  public class func instantiate(coordinator: DashboardDelegate?, summaryPayments: SummaryPayments
    
    
    //    delegate: DashboardDelegate?,
    //
    //    pagamentosAVencerQtd: Int,
    //    pagamentosAVencerTotalAPagar: Double,
    //
    //    pagamentosVencidosQtd: Int,
    //    pagamentosVencidosTotalAPagar: Double,
    //
    //    pagamentosExcluidosQtd: Int,
    //    pagamentosExcluidosTotalAPagar: Double
  
  ) -> DashboardTVC
  {
    let viewController = DashboardTVC()
    
    viewController.coordinator = coordinator
    viewController.summaryPayments = summaryPayments
    

    
    
    //    viewController.coordinator = delegate
    //    viewController.pagamentosAVencerQtd = pagamentosAVencerQtd
    //    viewController.pagamentosAVencerTotalAPagar = pagamentosAVencerTotalAPagar
    //    viewController.pagamentosVencidosQtd = pagamentosVencidosQtd
    //    viewController.pagamentosVencidosTotalAPagar = pagamentosVencidosTotalAPagar
    //    viewController.pagamentosExcluidosQtd = pagamentosExcluidosQtd
    //    viewController.pagamentosExcluidosTotalAPagar = pagamentosExcluidosTotalAPagar

    viewController.title = "central de pagamentos"
    return viewController
  }
  
}

// MARK: - Table view data source
extension DashboardTVC {
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch(section) {
    case 0: return 3
    default: fatalError("Unknown number of sections")
    }
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DashboardTVCell

    switch(indexPath.section) {
    case 0:
      switch(indexPath.row) {

      case 0:
        
        let viewModel = ViewModelQuantidadeDePagamentos(
          tipoDePagamento: .duePayment,
          quantidadeTotal: summaryPayments.quantityOfDuePayments ?? 0,
          valorTotal: summaryPayments.totalMonetaryValueOfDuePayments ?? 0
        )
        
        cell.beneficiarioLabel.attributedText = viewModel.quantidadeAttributedString
        cell.valorAPagarLabel.attributedText = viewModel.valorAttributedString
        cell.leftBarView.backgroundColor = UIColor.CustomStyle.yellow
        
        return cell
        
      case 1:

        let viewModel = ViewModelQuantidadeDePagamentos(
          tipoDePagamento: .overduePayment,
          quantidadeTotal: summaryPayments.quantityOfOverduePayments ?? 0,
          valorTotal: summaryPayments.totalMonetaryValueOfOverduePayments ?? 0
        )
        
        cell.beneficiarioLabel.attributedText = viewModel.quantidadeAttributedString
        cell.valorAPagarLabel.attributedText = viewModel.valorAttributedString
        cell.leftBarView.backgroundColor = UIColor.CustomStyle.purple
        
        return cell
        
      case 2:
        
        let viewModel = ViewModelQuantidadeDePagamentos(
          tipoDePagamento: .excludedPayment,
          quantidadeTotal: summaryPayments.quantityOfExcludedPayments ?? 0,
          valorTotal: summaryPayments.totalMonetaryValueOfExcludedPayments ?? 0
        )
        
        cell.beneficiarioLabel.attributedText = viewModel.quantidadeAttributedString
        cell.valorAPagarLabel.attributedText = viewModel.valorAttributedString
        cell.leftBarView.backgroundColor = UIColor.CustomStyle.darkRed
        
        return cell
        
      default: fatalError("Unknown row in section 0")
        
      }
    default: fatalError("Unknown section")
    }
    
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    tableView.deselectRow(at: indexPath, animated: false)

    switch(indexPath.section) {
    case 0:
      
      switch indexPath.row {
      case 0: coordinator?.startDuePaymentsNavigation()
      case 1: coordinator?.startOverduePaymentsNavigation()
      case 2: coordinator?.startExcludedPaymentsNavigation()
      default: fatalError("Unknown row in section 0")
      }
      
    default: fatalError("Unknown section")
    }

  }
  
}

