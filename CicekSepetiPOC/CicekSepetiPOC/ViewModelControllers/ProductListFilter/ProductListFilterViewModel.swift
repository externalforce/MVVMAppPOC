//
//  ProductListFilterViewModel.swift
//  CicekSepetiPOC
//
//  Created by BEGUMKIRKGOZ on 15.10.2020.
//

import UIKit

class ProductListFilterViewModel: BaseViewModel {
    
    var processFilteredProductList:     ((ProductListDataModel?)->())?
    var processFilterWithRequestModel:  (()->())?
    
    var requestModel = RequestModel()
    
//Call Products with Filters
    func getProductsByFilter(requestModel: RequestModel) {
        
        service.getProductsByFilter(requestModel: requestModel) { productListResponseModel  in
            if let model = productListResponseModel,  let result = model.result, let data = result.data, data.products?.count ?? 0 > 0 {
                self.processFilteredProductList!(data)
            }else if let model = productListResponseModel, let error = model.error, let message = error.message {
                self.showErrorWithServiceMessage!(message)
            }else if let model = productListResponseModel,  let result = model.result, let data = result.data, data.products?.count ?? 0 == 0 {
                self.showErrorWithServiceMessage!(noProductForFilter)
            }
            else{
                self.showError?()
            }
        }
    }

//Process Filter Model with user choice
    
    func processRequestModelWithFilter(valueModel: ValuesModel) {
        
        if valueModel.group == 1, valueModel.id != nil {
            if self.requestModel.detailList.contains(String(valueModel.id!))  {
                self.requestModel.detailList = self.requestModel.detailList.filter {$0 != String(valueModel.id!)}
            }else {
                self.requestModel.detailList.append(String(valueModel.id!))
            }
        }
        else if valueModel.group == 2, valueModel.id != nil {
            if self.requestModel.checkList.contains(String(valueModel.id!))  {
                self.requestModel.checkList = self.requestModel.checkList.filter {$0 != String(valueModel.id!)}
            }else {
                self.requestModel.checkList.append(String(valueModel.id!))
            }
        }
        else if valueModel.group == 3, valueModel.id != nil {
            if self.requestModel.priceList.contains(String(valueModel.id!))  {
                self.requestModel.priceList = self.requestModel.priceList.filter {$0 != String(valueModel.id!)}
            }else {
                self.requestModel.priceList.append(String(valueModel.id!))
            }
        }
        self.processFilterWithRequestModel!()
    }
    
}
