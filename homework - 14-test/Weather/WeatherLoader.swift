//
//  WeatherLoader.swift
//  homework - 14-test
//
//  Created by Зоригто Бадмаин on 24.10.2020.
//

import Foundation
import SVProgressHUD
import Alamofire

class WeatherLoader {
    static let shared = WeatherLoader()
    
    func loadWeather(completion: @escaping(String?) -> Void) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=Moscow&appid=d7ec9855a92e87e2705a78cc9f96846a") else { return }
        let request = URLRequest(url: url)
        SVProgressHUD.show()
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data,
               let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
               let jsonDict = json as? NSDictionary {
                let weather = jsonDict["main"] as! NSDictionary
                guard let currentHumidity = weather["humidity"] as? Int,
                      let currentPressure = weather["pressure"] as? Int,
                      let currentTemp = weather["temp"] as? Double else { return }
                
                let currentWeather = WeatherData()
                currentWeather.humidity = currentHumidity
                currentWeather.pressure = currentPressure
                currentWeather.temp = WeatherLoader.convertToCelsius(kelvin: currentTemp)
                
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                    WeatherRealmPersistent.shared.updateWeather(weather: currentWeather,
                                                                humidity: currentWeather.humidity,
                                                                pressure: currentWeather.pressure,
                                                                temp: currentWeather.temp)
                    let weatherText = "Now in Moscow:\n" +
                        "Humidity: \(currentWeather.humidity)\n" +
                        "Temperature: \(Int(currentWeather.temp))℃\n" +
                        "Pressure: \(currentWeather.pressure)"
                    completion(weatherText)
                }
            } else {
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                    completion(nil)
                }
            }
        }
        task.resume()
    }
    
    func loadWeatherDetailAlamofire(completion: @escaping([WeatherDetail]) -> Void) {
        SVProgressHUD.show()
        AF.request("https://api.openweathermap.org/data/2.5/forecast?q=Moscow&appid=d7ec9855a92e87e2705a78cc9f96846a").responseJSON { (response) in
            if let objects = response.value,
               let jsonDict = objects as? NSDictionary,
               let list = jsonDict["list"] as? [NSDictionary] {
                
                var weathers: [WeatherDetail] = []
                
                for data in list {
                    guard let dtTxt = data["dt_txt"] as? String,
                          let main = data["main"] as? NSDictionary,
                          let wind = data["wind"] as? NSDictionary,
                          let weather = data["weather"] as? [NSDictionary] else { return }
                   
                    
                    guard let humidity = main["humidity"] as? Int,
                          let pressure = main["pressure"] as? Int,
                          let tempKelv = main["temp"] as? Double else { return }
                    
                    guard let speed = wind["speed"] as? Double else { return }
                    guard let mn = weather[0]["main"] as? String else { return }
                    
                    let weatherDetail = WeatherDetail()
                    weatherDetail.dtTxt = dtTxt
                    weatherDetail.humidity = humidity
                    weatherDetail.pressure = pressure
                    weatherDetail.temp = WeatherLoader.convertToCelsius(kelvin: tempKelv)
                    weatherDetail.main = mn
                    weatherDetail.speed = speed
                    weathers.append(weatherDetail)
                }
                
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                    WeatherRealmPersistent.shared.addWeatherDetail(weathers: weathers)
                    completion(weathers)
                }
            } else {
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                    completion([])
                }
            }
        }
    }
}

extension WeatherLoader {
    static func convertToCelsius (kelvin: Double) -> Double {
        let modulCels = 273.15
        return kelvin - modulCels
    }
}
