//
//  ApiServices.swift
//  WeatherApp
//
//  Created by Abhisek K. on 11/06/21.
//

import Foundation

protocol CityWeatherService {
    func getCityWeather<T>(with name:String, completion: @escaping (Result<T,Error>) -> Void  )
}

class ApiServices: CityWeatherService{
    func getCityWeather<T>(with name: String, completion: @escaping (Result<T, Error>) -> Void) {
        
    }
}
