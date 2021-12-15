//
//  Service.swift
//  CicekSepetiPOC
//
//  Created by BEGUMKIRKGOZ on 14.10.2020.
//

import Foundation
import UIKit

struct ServiceConfig {
    private(set) var api:           String
    private(set) var baseUrl:       URL?
    private(set) var requestModel : RequestModel?
    
    var requestType:            HTTPRequestType
    var parameters:             [String: Any]?
    
    init(api: String, baseUrl: String = getBaseUrl(), requestModel : RequestModel?) {
        self.api = api
        self.requestModel = requestModel
        self.requestType = HTTPRequestType.HTTPGet
        self.baseUrl = getUrl(baseUrl, requestModel)
    }
}

func getUrl(_ baseUrl: String, _ requestModel: RequestModel?) -> URL? {
    var strUrl = baseUrl
    
    if requestModel != nil {
        strUrl = strUrl + "?" + (requestModel?.detailList.compactMap { "detailList=" + $0 + "&" })!.joined() + (requestModel?.checkList.compactMap { "checkList=" + $0 + "&" })!.joined() + (requestModel?.priceList.compactMap { "priceList=" + $0 + "&" })!.joined()
        
        if let lastChar = strUrl.last, lastChar == "&" {
            strUrl = String(strUrl.dropLast())
        }

    }
    guard let serviceUrl = URL(string: strUrl) else { return nil }
    return serviceUrl
}

func getBaseUrl() -> String {
    return Service.kBaseUrlLive
}

//MARK: APi Calls

protocol ServiceProtocol {
    func getProducts(completionHandler: @escaping (_ responseClass :ProductListResponseModel?) -> Void) -> Void
    func getProductsByFilter(requestModel: RequestModel, completionHandler: @escaping (_ responseClass :ProductListResponseModel?) -> Void) -> Void
}

class Service: ServiceProtocol {
    let request: RequestProtocol = Request()
    
    static let kBaseUrlLive = serviceURL
    
    func getProducts(completionHandler: @escaping (_ responseClass :ProductListResponseModel?) -> Void) -> Void {
        var serviceConfig = ServiceConfig(api: serviceURL, requestModel: nil)
        serviceConfig.requestType = HTTPRequestType.HTTPGet
        request.networkRequest(serviceConfig) { (productListResponseModel: ProductListResponseModel?) in
            completionHandler(productListResponseModel)
        }
    }
    
    func getProductsByFilter(requestModel: RequestModel, completionHandler: @escaping (_ responseClass :ProductListResponseModel?) -> Void) -> Void {
        var serviceConfig = ServiceConfig(api: serviceURL, requestModel: requestModel)
        serviceConfig.requestType = HTTPRequestType.HTTPGet
        request.networkRequest(serviceConfig) { (productListResponseModel: ProductListResponseModel?) in
            completionHandler(productListResponseModel)
        }
    }
}
