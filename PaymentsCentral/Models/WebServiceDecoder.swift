//
//  WebServiceDecoder.swift
//  PaymentsCentral
//
//  Created by Marcello Chuahy on 16/02/20.
//  Copyright © 2020 Applause Codes. All rights reserved.
//

struct WebServiceDecoder: Decodable {
  
  let duePayment:      [DayAndPayments]
  let overduePayment:  [DayAndPayments]
  let excludedPayment: [DayAndPayments]
  
  let quantityOfDuePayments: Int
  let totalMonetaryValueOfDuePayment: Double
  
  let quantityOfOverduePayments: Int
  let totalMonetaryValueOfOverduePayment: Double
  
  let quantityOfExcludedPayments: Int
  let totalMonetaryValueOfExcludedPayment: Double
  
  let paginaAtual: Int
  let ultimaPagina: Int
  
  let statusCode: Int
  
}
