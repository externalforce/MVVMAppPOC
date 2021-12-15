//
//  MainFilterModel.swift
//  CicekSepetiPOC
//
//  Created by BEGUMKIRKGOZ on 14.10.2020.
//

import Foundation

struct MainFilterModel: Codable {
    let dynamicFilter: [DynamicFilterModel]?
    let sort:          [SortModel]?
}
