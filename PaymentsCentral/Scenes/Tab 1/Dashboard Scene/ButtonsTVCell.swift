//
//  ButtonsTVCell.swift
//  PaymentsCentral
//
//  Created by Marcello Chuahy on 23/02/20.
//  Copyright © 2020 Applause Codes. All rights reserved.
//

import UIKit

protocol ButtonsDelegate: class {
  func startButtonANavigation()
  func startButtonBNavigation()
  func startButtonCNavigation()
}

class ButtonsTVCell: UITableViewCell {
  
  weak var coordinator: ButtonsDelegate?
  
  private lazy var stackView: UIStackView = { return UIStackView(frame: .zero) }()
  private lazy var buttonA: UIButton = { return UIButton(frame: .zero)}()
  private lazy var buttonB: UIButton = { return UIButton(frame: .zero)}()
  private lazy var buttonC: UIButton = { return UIButton(frame: .zero)}()
 
  // MARK: - Initialization
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    callsViewCodeMethodsInPreSetOrder()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    callsViewCodeMethodsInPreSetOrder()
  }
  
}

extension ButtonsTVCell: ViewCodeProtocol {
  
  func buildViewHierarchy() {

    stackView.addArrangedSubview(buttonA)
    stackView.addArrangedSubview(buttonB)
    stackView.addArrangedSubview(buttonC)

    contentView.addSubview(stackView)
    
  }
  
  func setupConstraints() {
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    buttonA.translatesAutoresizingMaskIntoConstraints = false
    buttonB.translatesAutoresizingMaskIntoConstraints = false
    buttonC.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
      stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
      stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
    ])
    
  }
  
  func setupComplementaryConfiguration() {
    
    // Cores
contentView.backgroundColor = UIColor.CustomStyle.backgroundGray
//    roundedView.backgroundColor = UIColor.CustomStyle.white
//    numberOfPayments.textColor = UIColor.CustomStyle.gray
//    monetaryValueLabel.textColor = UIColor.CustomStyle.darkGray
    
    // Stack view
    stackView.axis = NSLayoutConstraint.Axis.horizontal
    stackView.alignment = UIStackView.Alignment.fill
    stackView.distribution = UIStackView.Distribution.fill
    stackView.spacing = 16
    
    // Fonts
//    numberOfPayments.font = UIFont.CustomStyle.helveticaNeue_14
//    numberOfPayments.numberOfLines = 1
//    numberOfPayments.adjustsFontForContentSizeCategory = false
    
//    monetaryValueLabel.font = UIFont.CustomStyle.helveticaNeueBold_24
//    monetaryValueLabel.numberOfLines = 1
//    monetaryValueLabel.adjustsFontForContentSizeCategory = false
    
    // Outros
    buttonA.setTitle("This starts coordinator #1", for: .normal)
    buttonA.titleLabel?.font = UIFont.CustomStyle.helveticaNeue_14
    buttonA.titleLabel?.textColor = UIColor.CustomStyle.darkGray
    buttonA.backgroundColor = .lightGray
    buttonA.layer.cornerRadius = 4
    buttonA.addTarget(self, action: #selector(buttonAWasTapped(_:)), for: .touchUpInside)
    
    buttonB.setTitle("This starts coordinator #1", for: .normal)
    buttonB.titleLabel?.font = UIFont.CustomStyle.helveticaNeue_14
    buttonB.titleLabel?.textColor = UIColor.CustomStyle.darkGray
    buttonB.backgroundColor = .lightGray
    buttonB.layer.cornerRadius = 4
    buttonB.addTarget(self, action: #selector(buttonBWasTapped(_:)), for: .touchUpInside)
    
    buttonC.setTitle("This starts coordinator #1", for: .normal)
    buttonC.titleLabel?.font = UIFont.CustomStyle.helveticaNeue_14
    buttonC.titleLabel?.textColor = UIColor.CustomStyle.darkGray
    buttonC.backgroundColor = .lightGray
    buttonC.layer.cornerRadius = 4
    buttonC.addTarget(self, action: #selector(buttonCWasTapped(_:)), for: .touchUpInside)
    
  }
  
  @objc func buttonAWasTapped(_ sender: Any) { coordinator?.startButtonANavigation() }
  @objc func buttonBWasTapped(_ sender: Any) { coordinator?.startButtonBNavigation() }
  @objc func buttonCWasTapped(_ sender: Any) { coordinator?.startButtonCNavigation() }
  
  
}



