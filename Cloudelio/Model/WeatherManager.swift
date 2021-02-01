//
//  WeatherManager.swift
//  Cloudelio
//
//  Created by mohammad yasir on 31/01/21.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager : WeatherManager , weather : WeatherModel)
    func didFailWithError(error : Error)
}

struct WeatherManager {
    
    var delegate : WeatherManagerDelegate?
    
    
    
    func fetchWeather(latitude : CLLocationDegrees , longitude : CLLocationDegrees){
        let weatherURL = "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&exclude=minutely,hourly,daily,alerts&appid=6fcda4db7aabf9cf2c61c59f04882b22&units=metric"
        performRequest(with: weatherURL)
    }
    
    func performRequest(with urlString : String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
            
            task.resume()
        }
    }
    
    func handle(data : Data? , response : URLResponse? , error : Error?){
        if error != nil{
            delegate?.didFailWithError(error: error!)
            return
        }
        
        if let safeData = data {
            if let weather = parseJSON(safeData){
                delegate?.didUpdateWeather(self , weather : weather)
//                print(weather.temperature)
//                print(weather.dateFormating)

            }
        }
        
    }
    
    func parseJSON(_ weatherData : Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let temp = decodedData.current.temp
            let id = decodedData.current.weather[0].id
            let date = decodedData.current.dt
            let weather = WeatherModel(conditionId: id, temperature: temp, date: date)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
}
