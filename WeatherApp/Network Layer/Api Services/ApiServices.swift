//
//  ApiServices.swift
//  WeatherApp
//
//  Created by Abhisek K. on 11/06/21.
//

import Foundation

class ListService: CityWeatherService{
   
    func getCityWeather<T: Codable>(with name: String, completion: @escaping (Result<T?, NetworkError>) -> Void)  {
        
        let url = URLBuilder.init(path: .citySearch, queries: [QueryItem.init(queryName: .appID, queryValue: "0909090")])
        
        let networkModel = getNetworkRequestModel(url: url)
        
        callServer(networkModel: networkModel, T.self, completion: completion)
    }
}
