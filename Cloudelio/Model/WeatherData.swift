//
//  WeatherData.swift
//  Weathry
//
//  Created by mohammad yasir on 26/10/20.
//

import Foundation

struct WeatherData : Codable {
    let lat : Double
    let lon : Double
    let current : Current
}

struct Current : Codable {
    let temp : Double
//    let humidity : Int
//    let pressure : Int
    let dt : Int64
    let weather : [Weather]
}

struct Weather : Codable {
    let id : Int
}

