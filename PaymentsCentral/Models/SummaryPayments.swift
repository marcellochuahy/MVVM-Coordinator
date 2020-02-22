//
//  SummaryPayments.swift
//  PaymentsCentral
//
//  Created by Marcello Chuahy on 22/02/20.
//  Copyright © 2020 Applause Codes. All rights reserved.
//

struct SummaryPayments {
  
  /// Due Payments
  var quantityOfDuePayments: Int?
  var totalMonetaryValueOfDuePayments: Double?
  
  /// Overdue Payments
  var quantityOfOverduePayments: Int?
  var totalMonetaryValueOfOverduePayments: Double?
  
  /// Excluded Payments
  var quantityOfExcludedPayments: Int?
  var totalMonetaryValueOfExcludedPayments: Double?
  
}
