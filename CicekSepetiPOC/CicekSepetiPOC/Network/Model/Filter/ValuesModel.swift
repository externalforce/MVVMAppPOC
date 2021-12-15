//
//  ValuesModel.swift
//  CicekSepetiPOC
//
//  Created by BEGUMKIRKGOZ on 14.10.2020.
//

import Foundation

struct ValuesModel: Codable {
    let count:          Int?
    let id:             Int?
    let group:          Int?
    let detailValueId:  Int?
    
    let selected:       Bool?
    
    let link:               String?
    let filterQueryString:  String?
    let name:               String?
    let icon:               String?
}


