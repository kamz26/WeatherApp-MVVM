//
//  ApiServices.swift
//  WeatherApp
//
//  Created by Abhisek K. on 11/06/21.
//

import Foundation

class ListService: CityWeatherService{
    
    private var appId:String = "dc0ea2090cd862898f64a2affd7d7f9e"
   
    func getCityWeather<T: Codable>(with name: String, objectType:T.Type ,completion: @escaping (Result<T?, NetworkError>) -> Void)  {
        
        var queryItems: [QueryItem] = []
        
        let query1 = QueryItem.init(queryName: .query, queryValue: name)
        let query2 = QueryItem.init(queryName: .appID, queryValue: appId)
        
        queryItems.append(query1)
        queryItems.append(query2)
        
        let url = URLBuilder.init(path: .citySearch, queries: queryItems)
        
        let networkModel = getNetworkRequestModel(url: url)
        
        callServer(networkModel: networkModel, T.self, completion: completion)
    }
}
