//
//  WeatherViewController.swift
//  Baluchon
//
//  Created by Christophe DURAND on 05/09/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var foreignerCityNameLabel: UILabel!
    @IBOutlet weak var foreignerTemperatureLabel: UILabel!
    @IBOutlet weak var foreignerWeatherImage: UIImageView!
    @IBOutlet weak var localCityNameLabel: UILabel!
    @IBOutlet weak var localTemperatureLabel: UILabel!
    @IBOutlet weak var localWeatherImage: UIImageView!
    
    var weatherService = WeatherService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCityNameLabel()
        showWeather()
    }
    
    func showWeather() {
        weatherService.getForeignerWeather(city: .newYork) { (success, weather) in
            if success, let weather = weather {
                self.updateTempLabel(weatherTemp: weather)
                self.updateForeignerWeatherImage(weatherCode: weather)
                self.updateLocalWeatherImage(weatherCode: weather)
            } else {
                self.showAlert(title: "Error", message: "Weather's data download failed!")
            }
        }
    }
    
    func updateCityNameLabel() {
        foreignerCityNameLabel.text = "NEW YORK"
        localCityNameLabel.text = "PARIS"
    }

    func updateTempLabel(weatherTemp: WeatherCodeAndTemp) {
        foreignerTemperatureLabel.text = weatherTemp.newYorkTemp + "°C"
        localTemperatureLabel.text = weatherTemp.parisTemp + "°C"
    }
    
    func updateForeignerWeatherImage(weatherCode: WeatherCodeAndTemp) {
        if let iconForecast = WeatherCode.convertYahooCodeIntoIconForecast(code: weatherCode.newYorkCode) {
            let foreignerForecastImage = UIImage(named: iconForecast)
            foreignerWeatherImage.image = foreignerForecastImage
        }
    }
    
    func updateLocalWeatherImage(weatherCode: WeatherCodeAndTemp) {
        if let iconForecast = WeatherCode.convertYahooCodeIntoIconForecast(code: weatherCode.parisCode) {
            let localForecastImage = UIImage(named: iconForecast)
            localWeatherImage.image = localForecastImage
        }
    }
}
