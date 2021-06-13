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
    func update(model:NSManagedObject)
    func delete(mode:NSManagedObject)
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
            
            let weatherList = LocalWeatherList(context: context)
            weatherList.addToWeatherList(weather)
            
            do{
                try context.save()
                completion(nil)
            }catch{
                debugPrint(error)
                completion(error)
            }
        }
    }
    
    func update(model: NSManagedObject) {
        debugPrint("Update")
    }
    
    func delete(mode: NSManagedObject) {
        debugPrint("Delete")
    }
    
    func fetchData() -> NSManagedObject? {
        
        do{
            let items =  try context.fetch(LocalWeatherList.fetchRequest()) as? [LocalWeatherList]
            return items?.first
        }catch{
            
            debugPrint(error)
            return nil
        }
        return nil
    }
    
}
