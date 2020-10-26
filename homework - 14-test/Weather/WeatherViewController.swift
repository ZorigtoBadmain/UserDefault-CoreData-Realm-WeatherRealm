//
//  WeatherViewController.swift
//  homework - 14-test
//
//  Created by Зоригто Бадмаин on 24.10.2020.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var weatherLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showWeather()
        showRealmWeather()
     
    }
  
    func showWeather() {
        WeatherLoader.shared.loadWeather { (weather) in
            if let weather = weather {
                self.weatherLabel.text = "\(weather)"
                self.weatherLabel.textColor = .black
            } else {
                self.showRealmWeather()
            }
        }
    }
    
    func showRealmWeather() {
        weatherLabel.textColor = .red
        if let realmWeather = WeatherRealmPersistent.shared.weather {
            weatherLabel.text = "Sometime in Moscow:\n" +
                "Humidity: \(realmWeather.humidity)\n" +
                "Temperature: \(Int(realmWeather.temp))℃\n" +
                "Pressure: \(realmWeather.pressure)"
        } else {
            weatherLabel.text = "Интернет соединение отключено"
        }
    }

}
