//
//  WeatherModel.swift
//  Weathry
//
//  Created by mohammad yasir on 26/10/20.
//

import Foundation

struct WeatherModel {
    let conditionId : Int
    let temperature : Double
    let date : Int64
    
    
    var dateFormating : String {
        let date_ = Date(timeIntervalSince1970: TimeInterval(date))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd-yyyy" 
        let localDate = dateFormatter.string(from: date_)
        return localDate
    }
    
    
    var conditionName : String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800 :
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
}
