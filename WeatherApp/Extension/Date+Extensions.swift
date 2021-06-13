//
//  Date+Extensions.swift
//  WeatherApp
//
//  Created by Abhisek K. on 13/06/21.
//

import Foundation


extension Date{
    func toStringFormattedWith(format:String = "hh:mm a") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
