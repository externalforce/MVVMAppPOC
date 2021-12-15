//
//  ProductListResponseModel.swift
//  CicekSepetiPOC
//
//  Created by BEGUMKIRKGOZ on 14.10.2020.
//

import Foundation

struct ProductListResponseModel: Codable {
    let error:      ErrorModel?
    let result:     ProductListResultModel?
}
