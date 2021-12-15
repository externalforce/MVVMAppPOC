//
//  ProductListDataModel.swift
//  CicekSepetiPOC
//
//  Created by BEGUMKIRKGOZ on 14.10.2020.
//

import Foundation

struct ProductListDataModel: Codable {
    let productCount:       Int?
    let storeId:            Int?
    
    let isAlternate:        Bool?
    let hasOldPrice:        Bool?
    
    let categoryName:       String?
    let filter:             String?
    let banners:            String?
    let branch:             String?
    let message:            String?
    let title:              String?
    let backgroundColor:    String?
  
    let products:           [ProductModel]?
    let mainFilter:         MainFilterModel?
    let subCategoryModel:   SubCategoryModel?
}
