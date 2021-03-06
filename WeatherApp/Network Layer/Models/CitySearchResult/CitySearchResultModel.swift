//
//  CitySearchResultModel.swift
//  WeatherApp
//
//  Created by Abhisek K. on 12/06/21.
//

import Foundation

// MARK: - Welcome
struct CitySearchResultModel: Codable {
    let coord: Coord?
    let weather: [Weather]?
    let base: String?
    let main: Main?
    let visibility: Int?
    let wind: Wind?
    let clouds: Clouds?
    let dt: Int?
    let sys: Sys?
    let timezone, id: Int?
    let name: String?
    let cod: Int?
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int?
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double?
}

// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double?
    let pressure, humidity: Int?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

extension Main{
    var formattedMinTemp: String{
        return "\(tempMin?.description ?? "") \u{00B0}"
    }
    
    var formattedMaxTemp: String{
        return "\(tempMax?.description ?? "") \u{00B0}"
    }
}

// MARK: - Sys
struct Sys: Codable {
    let type, id: Int?
    let country: String?
    let sunrise, sunset: Int?
}

extension Sys{
    var sunriseFormattedTime: String{
        // convert Int to TimeInterval (typealias for Double)
        let timeInterval = TimeInterval(sunrise ?? 0)

        // create NSDate from Double (NSTimeInterval)
        let myDate = Date(timeIntervalSince1970: timeInterval)
        
        return myDate.toStringFormattedWith()
    }
    
    var sunsetFormattedTime: String{
        // convert Int to TimeInterval (typealias for Double)
        let timeInterval = TimeInterval(sunset ?? 0)

        // create NSDate from Double (NSTimeInterval)
        let myDate = Date(timeIntervalSince1970: timeInterval)
        
        return myDate.toStringFormattedWith()
    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int?
    let main, weatherDescription, icon: String?

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double?
    let deg: Int?
}

