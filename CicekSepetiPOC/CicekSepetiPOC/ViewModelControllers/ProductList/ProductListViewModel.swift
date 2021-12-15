//
//  ProductListViewModel.swift
//  CicekSepetiPOC
//
//  Created by BEGUMKIRKGOZ on 14.10.2020.
//

import Foundation

class ProductListViewModel: BaseViewModel {
    
    var processProductList: ((ProductListDataModel?)->())? 
    
//Call Products without Filters.
    func getProducts() {
        service.getProducts(){ productListResponseModel  in
            if let model = productListResponseModel,  let result = model.result, let data = result.data {
                self.processProductList!(data)
            }else if let model = productListResponseModel, let error = model.error, let message = error.message {
                self.showErrorWithServiceMessage!(message)
            }
            else{
                self.showError?()
            }
        }
    }
}
