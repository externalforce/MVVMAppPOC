//
//  DynamicFilterModel.swift
//  CicekSepetiPOC
//
//  Created by BEGUMKIRKGOZ on 14.10.2020.
//

import Foundation

struct DynamicFilterModel: Codable {
    let id:                 Int?
    let detailId:           Int?
    let sequence:           Int?
    let filterType:         Int?
    let urlTag:             Int?
    let filterBehaviour:    Int?
    
    let isMainCategory:     Bool?
    let isReload:           Bool?
    let isRemovableDetail:  Bool?
    
    let name:               String?
    let clearLink:          String?
    
    let values: [ValuesModel]?
}
