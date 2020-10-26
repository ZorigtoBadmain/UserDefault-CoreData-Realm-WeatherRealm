//
//  DetailViewController.swift
//  homework - 14-test
//
//  Created by Зоригто Бадмаин on 25.10.2020.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var weatherDetailTableView: UITableView!
    var weathers: [WeatherDetail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherDetailTableView.dataSource = self
        
        showRealmWeather()
        showWeather()
    }
    
    func showWeather() {
        WeatherLoader.shared.loadWeatherDetailAlamofire { (weathers) in
            if weathers.isEmpty {
                self.showRealmWeather()
            } else {
                self.weathers = weathers
                self.weatherDetailTableView.separatorColor = .lightGray
                self.weatherDetailTableView.reloadData()
            }
        }
    }
    
    func showRealmWeather() {
        weathers = WeatherRealmPersistent.shared.weathers
        weatherDetailTableView.separatorColor = .red
        weatherDetailTableView.reloadData()
    }

}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weathers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherDetailCell", for: indexPath) as! DetailTableViewCell
        let data = weathers[indexPath.row]
        let temp: Int = Int(data.temp)
        let pressure = data.pressure
        let humidity = data.humidity
        let speed = data.speed
        let weather = data.main
        
        cell.dateLabel.text = data.dtTxt
        cell.weatherLabel.text = "Temperature: \(temp)℃\n" +
                                 "Pressure: \(pressure)\n" +
                                 "Humidity: \(humidity)\n" +
                                 "Wind speed: \(speed)m/s" +
                                 "\(weather)"
        
        return cell
    }
    
    
}
