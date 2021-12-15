//
//  ProductModel.swift
//  CicekSepetiPOC
//
//  Created by BEGUMKIRKGOZ on 14.10.2020.
//

import Foundation

struct ProductModel: Codable {
    let id:                     Int?
    let productGroupId:         Int?
    let entryId:                Int?
    let reviewRating:           Double?
    let reviewCount:            Int?
    let productType:            Int?
    let deliveryBadgeType:      Int?
    
    let isMarketplace:          Bool?
    let isOriginal:             Bool?
    let installment:            Bool?
    let mostSellestProduct:     Bool?
    let isHaveVase:             Bool?
    let isSubscription:         Bool?
    let isDiscountAvailable:    Bool?
    
    let code:                   String?
    let name:                   String?
    let image:                  String?
    let link:                   String?
    let webLink:                String?
    let deliveryBadgeText:      String?
    let deliveryChargeText:     String?
    let marketplaceBranch:      String?
    let largeImage:             String?
    let installmentText:        String?
    let smallImage:             String?
    let xlargeImage:            String?
    let mediumImage:            String?
    let isHaveVaseText:         String?
    let variantCode:            String?
    let deliveryChargeMessage:  String?
    let information:            String?
    
    let price: PriceModel?
    let productDeliveryCity: ProductDeliveryCityModel?
}
