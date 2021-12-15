//
//  PriceModel.swift
//  CicekSepetiPOC
//
//  Created by BEGUMKIRKGOZ on 14.10.2020.
//

import Foundation

struct PriceModel: Codable {
    let current:                        Double?
    let old:                            Double?
    let tax:                            Double?
    let total:                          Double?
    let oldTotal:                       Double?
    let discountPercentage:             Double?
    let subscriptionPrice:              Double?
    let subscriptionDiscountPercentage: Double?
    
    let showFirstPrice:                 Bool?
    let showCurrencyCode:               Bool?
    let showDecimalPart:                Bool?
    
    let currency:                       String?
    let currencyCode:                   String?
}
