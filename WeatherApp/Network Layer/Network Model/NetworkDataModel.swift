//
//  NetworkDataModel.swift
//  WeatherApp
//
//  Created by Abhisek K. on 12/06/21.
//

import Foundation
import Alamofire

struct NetworkRequestModel {
    var urlString: String
    var postParams: [String:Any]?
    var headerParams: [String:String]?
    var requestType: HTTPMethod
    
    init(url:String, postParams: [String:Any]?, headerParams:[String:String]?, requestType:HTTPMethod){
        
        self.urlString = url
        self.postParams = postParams
        self.headerParams = headerParams
        self.requestType = requestType
    }
}

struct NetworkResponseModel {
    var responseData: DataResponse<Any>?
    var error: NetworkError?
}

enum NetworkError: Error{
    case noData
    case decodingFailed
    case networkResponse
}


struct ParserModel<T: Codable> : Codable {
    var model: T
    
    init(model: T) {
        self.model = model
    }
}
