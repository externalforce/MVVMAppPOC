//
//  BaseViewModel.swift
//  CicekSepetiPOC
//
//  Created by BEGUMKIRKGOZ on 14.10.2020.
//

import UIKit

class BaseViewModel {
 //MARK: Base Closure
    var closeIndicator:             (()->())?
    var showError:                  (()->())?
    var showErrorWithServiceMessage:((String?)->())?
    
    let service: ServiceProtocol

    init(service: ServiceProtocol = Service()) {
        self.service = service
    }
}
