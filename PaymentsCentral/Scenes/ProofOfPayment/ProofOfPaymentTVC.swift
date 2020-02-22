//
//  ProofOfPaymentTVC.swift
//  Example2-MVC-ViewCode
//
//  Created by Marcello Chuahy on 16/02/20.
//  Copyright © 2020 Applause Codes. All rights reserved.
//

import UIKit

protocol ProofOfPaymentDelegate: class {
  func dismiss()
}

// ProofOfPaymentTVC
class ProofOfPaymentTVC: UITableViewController {
  
  // MARK: - Properties
  weak var coordinator: ProofOfPaymentDelegate?
  var monetaryValue: Double?
  var beneficiary: String?
  
  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
  }
  
  // MARK: - Methods
  func setupTableView() {
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 347
    tableView.register(CelulaDoComprovanteDePagamento.self, forCellReuseIdentifier: "cell")
  }
  
  @objc func dimissButtonWasPressed() {
    dismiss(animated: true, completion: nil)
  }
  
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CelulaDoComprovanteDePagamento
    
    cell.valorAPagarLabel.text = "R$ \(monetaryValue ?? 0)"
    cell.beneficiarioLabel.text = beneficiary
    cell.beneficiarioLabel.numberOfLines = 0
    
    return cell
    
  }
  
}

// MARK: - Constructor
extension ProofOfPaymentTVC {
  
  public class func instantiate(coordinator: ProofOfPaymentDelegate?, beneficiary: String, monetaryValue: Double) -> ProofOfPaymentTVC {
    
    let viewController = ProofOfPaymentTVC()
    
    viewController.title = "comprovante"
    viewController.coordinator = coordinator
    viewController.beneficiary = beneficiary
    viewController.monetaryValue = monetaryValue
    
    return viewController
    
  }
  
}
