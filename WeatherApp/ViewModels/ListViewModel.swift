//
//  ListViewModel.swift
//  WeatherApp
//
//  Created by Abhisek K. on 12/06/21.
//

import Foundation


class ListViewModel{
    
    let listService:CityWeatherService
    var citySearchResult:[CitySearchResultModel?]
    init() {
        self.listService = ListService()
        self.citySearchResult = []
    }
    
    
    func getCityData(cityName:String, completion: @escaping (NetworkError?) -> Void){
        self.listService.getCityWeather(with: cityName, objectType: CitySearchResultModel.self) { (result) in
            
            switch result{
            case .success(let cityModel):
                self.citySearchResult.append(cityModel)
                completion(nil)
            case .failure(let error ):
                completion(error)
            }
        }
    }
}
