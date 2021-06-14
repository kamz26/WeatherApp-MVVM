//
//  ListViewModel.swift
//  WeatherApp
//
//  Created by Abhisek K. on 12/06/21.
//

import Foundation


class ListViewModel{
    //MARK: - Variables
    private let listService:CityWeatherService
    private let weatherStorageService:DataStoreService
    
    var citySearchResult:[CitySearchViewModel?]
    var favoriteSearch: LocalWeatherList?
    var favSearchList: [CitySearchViewModel?]
    
    init() {
        
        self.listService = ListService()
        self.weatherStorageService = WeatherListStoreService()
        
        self.citySearchResult = []
        favSearchList = []
    }
    
    
    func getCityData(cityName:String, completion: @escaping (NetworkError?) -> Void){
        self.listService.getCityWeather(with: cityName, objectType: CitySearchResultModel.self) {[weak self] (result) in
            
            switch result{
            case .success(let cityModel):
                let model = CitySearchViewModel(isFAv: false, name: cityModel?.name ?? "", minTemp: cityModel?.main?.formattedMinTemp ?? "", maxTemp: cityModel?.main?.formattedMaxTemp ?? "", sunrise: cityModel?.sys?.sunriseFormattedTime ?? "", sunset: cityModel?.sys?.sunsetFormattedTime ?? "")
            
                self?.citySearchResult.append(model)
                completion(nil)
            case .failure(let error ):
                completion(error)
            }
        }
    }
    
    func removeFromFav(index:Int, completion: @escaping (Error?) -> Void ){
        weatherStorageService.delete(model: self.favSearchList[index]) { [weak self](error) in
           if error == nil{
                self?.favSearchList.remove(at: index)
            }
            completion(error)
        }
    }
    
    func addToFav(index:Int, completion: @escaping (Error?) -> Void){
        weatherStorageService.add(model: self.citySearchResult[index]){ [weak self] error in
            if error == nil{
                self?.citySearchResult.remove(at: index)
            }
            completion(error)
        }
        updateLocalFetch()
    }
    
    func updateLocalFetch(){
        favoriteSearch = weatherStorageService.fetchData() as? LocalWeatherList
        updateListData()
    }
    
    func updateListData(){
        
        self.favSearchList = []
        for item in favoriteSearch?.weatherList ?? []{
            if let localWeather = item as? LocalWeather{
                self.favSearchList.append(
                    CitySearchViewModel.init(isFAv: localWeather.isFav,
                                             name: localWeather.locationName ?? "",
                                             minTemp: localWeather.minTemp ?? "",
                                             maxTemp: localWeather.maxTemp ?? "",
                                             sunrise: localWeather.sunrise ?? "",
                                             sunset: localWeather.sunset ?? "")
                )
            }
        }
        
    }
}


struct CitySearchViewModel: Codable{
    var isFAv:Bool
    var name:String
    var minTemp: String
    var maxTemp: String
    var sunrise: String
    var sunset: String
}
