//
//  ListViewModel.swift
//  WeatherApp
//
//  Created by Abhisek K. on 12/06/21.
//

import Foundation


struct ListViewModel{
    
    let listService:CityWeatherService
    
    init() {
        self.listService = ListService()
    }
    
    
    func getCityData(){
        
    }
}
