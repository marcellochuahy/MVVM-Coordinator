//
//  WebServiceDecoder.swift
//  Example of MVVM-C Pattern
//
//  Created by Marcello Chuahy on 16/02/20.
//  Copyright © 2020 Applause Codes. All rights reserved.
//

struct WebServiceDecoder: Decodable {
  
  let duePayment:      [DayAndPayments]
  let overduePayment:  [DayAndPayments]
  let excludedPayment: [DayAndPayments]
  
  let quantityOfDuePayments: Int
  let totalMonetaryValueOfDuePayments: Double
  
  let quantityOfOverduePayments: Int
  let totalMonetaryValueOfOverduePayments: Double
  
  let quantityOfExcludedPayments: Int
  let totalMonetaryValueOfExcludedPayments: Double
  
  let actualPage: Int
  let lastPage: Int
  
  let statusCode: Int
  
}
