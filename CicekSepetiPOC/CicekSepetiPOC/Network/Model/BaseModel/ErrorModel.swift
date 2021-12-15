//
//  ErrorModel.swift
//  CicekSepetiPOC
//
//  Created by BEGUMKIRKGOZ on 14.10.2020.
//

import Foundation

struct ErrorModel: Codable {
    let type:       Int?
    let title:      String?
    var message:    String?
    let returnUrl:  String?
}
