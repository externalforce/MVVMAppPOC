//
//  Request.swift
//  CicekSepetiPOC
//
//  Created by BEGUMKIRKGOZ on 14.10.2020.
//
import Foundation

enum HTTPRequestType: String {
    case HTTPGet = "Get"
    case HTTPPost = "Post"
}

protocol RequestProtocol {
    func networkRequest<T: Decodable>(_ serviceConf: ServiceConfig, completionHandler:@escaping (T?) -> Void)
}

class Request: RequestProtocol {
    
    func initRequest(_ serviceConfig: ServiceConfig) -> URLRequest {
        var request = URLRequest(url: serviceConfig.baseUrl!)
        request.httpMethod = serviceConfig.requestType.rawValue
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
        request.timeoutInterval = 20.0
        if serviceConfig.parameters != nil {
            do {
                if serviceConfig.requestType == HTTPRequestType.HTTPPost {
                    request.httpBody = try JSONSerialization.data(withJSONObject: serviceConfig.parameters!, options: .prettyPrinted)
                }
                else if serviceConfig.requestType == HTTPRequestType.HTTPGet {
                }
            } catch let error {
                print(error)
            }
        }
        return request
    }
    
    func sendRequest(_ serviceConfig: ServiceConfig, completionHandler: @escaping (_ responseData: Data?) -> Void) {
        let session :URLSession
        
            session = URLSession.shared
                
        session.dataTask(with: initRequest(serviceConfig)) { (data, response, error) in
            if error != nil {
                completionHandler(data)
                return
            }
            guard let _ = response else {
                return
            }
            guard let data = data else {
                return
            }
            
            completionHandler(data)
            }.resume()
    }
    
    func networkRequest<T: Decodable>(_ serviceConf: ServiceConfig, completionHandler:@escaping (T?) -> Void) {
        sendRequest(serviceConf) { (Data) in
            if Data != nil {
                completionHandler(self.createModelObjectWith(Object: T.self, json: Data!))
            }
            else {
                completionHandler(nil)
            }
            
        }
    }

    func createModelObjectWith<T: Decodable>(Object:T.Type, json: Data) -> T? {
        do {
            let decoder = JSONDecoder()
            let model = try decoder.decode(T.self, from: json)
            return model
        } catch let error {
            print(error)
            return nil
        }
    }
}
