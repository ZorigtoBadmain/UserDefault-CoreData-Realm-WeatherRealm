//
//  WeatherRealmPersistent.swift
//  homework - 14-test
//
//  Created by Зоригто Бадмаин on 24.10.2020.
//

import Foundation
import RealmSwift

class WeatherRealmPersistent {
    static var shared = WeatherRealmPersistent()
    
    private let realm = try! Realm()
    
    var weather: WeatherData? {
        return realm.objects(WeatherData.self).first
    }
    
    func updateWeather(weather: WeatherData, humidity: Int, pressure: Int, temp: Double) {
        try! realm.write {
            if realm.objects(WeatherData.self).isEmpty {
                realm.add(weather)
            } else {
                weather.humidity = humidity
                weather.pressure = pressure
                weather.temp = temp
            }
        }
    }
    
    var weathers: [WeatherDetail] {
        var weathers: [WeatherDetail] = []
        for weather in realm.objects(WeatherDetail.self) {
            weathers.append(weather)
        }
        return weathers
    }
    
    func addWeatherDetail(weathers: [WeatherDetail]) {
        try! realm.write {
            realm.add(weathers, update: .all)
        }
        print(realm.objects(WeatherDetail.self).count)
    }
}
