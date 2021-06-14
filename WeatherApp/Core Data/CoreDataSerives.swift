//
//  CoreDataSerives.swift
//  WeatherApp
//
//  Created by Abhisek K. on 14/06/21.
//

import Foundation
import CoreData
import UIKit


protocol DataStoreService {
    func add(model:Codable, completion:@escaping (Error?) -> Void)
    func delete(model:Codable, completion:@escaping (Error?) -> Void)
    func fetchData() -> NSManagedObject?
}


class WeatherListStoreService: DataStoreService{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func add(model: Codable, completion:@escaping (Error?) -> Void) {
        
        if let weatherModel = model as? CitySearchViewModel{
            
            let weather = LocalWeather(context: context)
            weather.isFav = true
            weather.locationName = weatherModel.name
            weather.maxTemp = weatherModel.maxTemp
            weather.minTemp = weatherModel.minTemp
            weather.sunrise = weatherModel.sunrise
            weather.sunset = weatherModel.sunset
            
            
            if let firstWeatherList = fetchData() as? LocalWeatherList{
                firstWeatherList.addToWeatherList(weather)
            }else{
                let model = LocalWeatherList(context: context)
                model.addToWeatherList(weather)
            }
            
            do{
                try context.save()
                completion(nil)
            }catch{
                debugPrint(error)
                completion(error)
            }
        }
    }
    
    func delete(model: Codable, completion:@escaping (Error?) -> Void) {
        debugPrint("Delete")
        
        if let firstWeatherList = fetchData() as? LocalWeatherList, let weather = model as? CitySearchViewModel{
            
            for item  in firstWeatherList.weatherList ?? []{
                if let localWeather = item as? LocalWeather{
                    if localWeather.locationName == weather.name{
                        context.delete(localWeather)
                    }
                }
                
            }
        }
        
        do{
            try context.save()
            completion(nil)
        }catch{
            debugPrint(error)
            completion(error)
        }
    }
    
    func fetchData() -> NSManagedObject? {
        do{
            let items =  try context.fetch(LocalWeatherList.fetchRequest()) as? [LocalWeatherList]
            return items?.first
        }catch{
            debugPrint(error)
            return nil
        }
    }
    
}
