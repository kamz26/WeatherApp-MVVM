//
//  ServiceUrl.swift
//  WeatherApp
//
//  Created by Abhisek K. on 11/06/21.
//

import Foundation


enum ServiceUrl{
    
    //MARK: - Base Url
    enum ServiceBaseUrl{
        static let baseUrl = "https://api.openweathermap.org"
    }
    
    //MARK: - Request Key
    enum RequestKey: String {
        case query                  = "q"
        case appID                  = "appid"
    }
    
    //MARK: - Service Url Path
    enum ServiceURLPath: String{
        //MARK: - Search City
        case citySearch = "/data/2.5/weather"
    }
    
    case getUrl(_ builder: URLBuilder)
    
    
    var url: String {
        switch self {
        case .getUrl(let builder):
            
            return ServiceUrl.ServiceBaseUrl.baseUrl + "\(builder.path.rawValue)" + "\(getQueryParamString(builder))"
        }
    }
    
    func getQueryParamString(_ builder:URLBuilder) -> String{
        guard builder.queries.count > 0 else {return ""}
        
        var queryString = "?"
        for (index,query) in builder.queries.enumerated(){
            queryString.append( index == builder.queries.count - 1 ? "\(query.queryName.rawValue)=\(query.queryValue)" : "\(query.queryName.rawValue)=\(query.queryValue)&" )
        }
        return queryString
    }
    
    
}


struct URLBuilder{
    typealias UrlPath = ServiceUrl.ServiceURLPath
    let path: UrlPath
    let queries:[QueryItem]
    
    init(path:UrlPath, queries:[QueryItem]) {
        self.path = path
        self.queries = queries
    }
}

struct QueryItem {
    let queryName: ServiceUrl.RequestKey
    let queryValue: String
}
