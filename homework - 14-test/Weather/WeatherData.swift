//
//  WeatherData.swift
//  homework - 14-test
//
//  Created by Зоригто Бадмаин on 24.10.2020.
//

import Foundation
import RealmSwift

class WeatherData: Object {
    @objc dynamic var humidity = Int()
    @objc dynamic var pressure = Int()
    @objc dynamic var temp = Double()
}

class WeatherDetail: WeatherData {
    @objc dynamic var dtTxt = String()
    @objc dynamic var speed = Double()
    @objc dynamic var main = String()
    
    override static func primaryKey() -> String? {
        return "dtTxt"
    }
}
