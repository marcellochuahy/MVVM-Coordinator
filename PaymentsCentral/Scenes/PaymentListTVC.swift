//
//  ListaDePagamentos.swift
//  Example2-MVC-ViewCode
//
//  Created by Marcello Chuahy on 16/02/20.
//  Copyright © 2020 Applause Codes. All rights reserved.
//

import UIKit

protocol PaymentListDelegate: class {
  func pagarBoleto(indexPath: IndexPath)
}

class PaymentListTVC: UITableViewController {
  
  // MARK: - Properties
  weak var delegate: PaymentListDelegate?
  var tipoDePagamento: TypeOfPayment?
  var paymentsDataSource: [DayAndPayments]?
  
  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
  }
  
  // MARK: - Methods
  func setupTableView() {
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 80
    tableView.backgroundColor = UIColor.CustomStyle.white
    tableView.register(PaymentListTVCell.self, forCellReuseIdentifier: "cell")
  }

}

// MARK: - Table view data source
extension PaymentListTVC {
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return paymentsDataSource?.count ?? 0
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return paymentsDataSource?[section]?.keys.first
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let key = paymentsDataSource?[section]?.keys.first else { return 0 }
    let payments = paymentsDataSource?[section]?[key] ?? []
    return payments.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PaymentListTVCell
    
    guard let key = paymentsDataSource?[indexPath.section]?.keys.first else { return cell }
    
    let payments     = paymentsDataSource?[indexPath.section]?[key]
    let beneficiary = payments?[indexPath.row].beneficiary
    let monetaryValue  = payments?[indexPath.row].monetaryValue ?? 0
    
    cell.beneficiarioLabel.numberOfLines = 0
    cell.beneficiarioLabel.text = beneficiary
    cell.valorAPagarLabel.text  = "\(monetaryValue)"
    cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    tableView.deselectRow(at: indexPath, animated: false)
    
    delegate?.pagarBoleto(indexPath: indexPath)
    
  }
  
}

// MARK: - Constructor
extension PaymentListTVC {
  
  public class func instantiate(delegate: PaymentListDelegate?, title: String
    
    //,
    //tipoDePagamento: TypeOfPayment?,
    //paymentsDataSource: [DayAndPayments]?
    
    
  )
    -> PaymentListTVC
  {
    
    let viewController = PaymentListTVC()
    
    viewController.delegate = delegate
    viewController.title = title
    
    //viewController.coordinator = delegate
    //viewController.title = "pagamentos \(tipoDePagamento?.rawValue ?? "")"
    //viewController.paymentsDataSource = paymentsDataSource

    return viewController
    
    
  }
}

