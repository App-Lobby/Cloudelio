//
//  ViewController.swift
//  Cloudelio
//
//  Created by mohammad yasir on 31/01/21.
//

import UIKit
import CoreLocation



class WeatherViewController: UIViewController , CLLocationManagerDelegate , WeatherManagerDelegate{
    
    // Outlets
    @IBOutlet weak var currentConditionImage: UIImageView!
    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var timer = Timer()
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // UI Color Changes
        currentConditionImage.tintColor = .white
        currentConditionImage.image = UIImage(systemName: "cloud.bolt.rain")
        
        // Subscribing
        weatherManager.delegate = self
        locationManager.delegate = self
        
        // CoreLocation
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        // Timer to Show Current Time
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(self.tick) , userInfo: nil, repeats: true)
        
    }
    
    @objc func tick() {
        timeLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short)
    }
    
    // Fetching current location lat and lon and passing to weather manager 
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            
//            print(lat)
//            print(lon)
//
            weatherManager.fetchWeather(latitude : lat , longitude : lon)
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func didUpdateWeather(_ weatherManager : WeatherManager , weather : WeatherModel){
        DispatchQueue.main.async {
            self.currentConditionImage.image = UIImage(systemName: weather.conditionName)
            self.currentTemp.text = String(Int(weather.temperature)) + "°"
            self.dateLabel.text = weather.dateFormating
        }
        print("sdfsdf")
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }

}



