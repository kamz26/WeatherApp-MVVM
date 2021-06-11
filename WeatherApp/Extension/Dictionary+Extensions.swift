//
//  Dictionary+Extensions.swift
//  WeatherApp
//
//  Created by Abhisek K. on 12/06/21.
//

import Foundation


// MARK: - Dictionary
extension Dictionary {
    
    mutating func append(otherDict:Dictionary) {
        for (key,value) in otherDict {
            self.updateValue(value, forKey:key)
        }
    }
    
    func jsonRepresentation() -> String {
        let data =  try! JSONSerialization.data(withJSONObject: self, options: [])
        return String(data:data, encoding:.utf8)!
    }
}
