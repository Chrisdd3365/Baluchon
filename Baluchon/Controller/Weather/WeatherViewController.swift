//
//  WeatherViewController.swift
//  Baluchon
//
//  Created by Christophe DURAND on 05/09/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var foreignerCityNameLabel: UILabel!
    @IBOutlet weak var foreignerTemperatureLabel: UILabel!
    @IBOutlet weak var foreignerWeatherImage: UIImageView!
    @IBOutlet weak var foreignerActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var localCityNameLabel: UILabel!
    @IBOutlet weak var localTemperatureLabel: UILabel!
    @IBOutlet weak var localWeatherImage: UIImageView!
    @IBOutlet weak var localActivityIndicator: UIActivityIndicatorView!
    
    //MARK: - Properties
    var weatherService = WeatherService()
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCityNameLabel()
        showLocalWeather()
    }
    
    //MARK: - Methods
    //Method to call the getForeignerWeather method from WeatherServivce and retrieve data of New York
    private func showForeignerWeather() {
        weatherService.getWeather(city: .newYork) { (success, weather) in
            self.toggleForeignerActivityIndicator(shown: true)
            if success, let weather = weather {
                self.toggleForeignerActivityIndicator(shown: false)
                self.updateForeignerTempLabel(weatherTemp: weather)
                self.updateForeignerWeatherImage(weatherCode: weather)
            } else {
                self.showAlert(title: "Error", message: "Weather's data for New York download failed!")
            }
        }
    }
    //Method to call the getWeather method from WeatherService and retrieving data of Paris
    private func showLocalWeather() {
        weatherService.getWeather(city: .paris) { (success, weather) in
            self.toggleLocalActivityIndicator(shown: true)
            if success, let weather = weather {
                self.showForeignerWeather()
                self.toggleLocalActivityIndicator(shown: false)
                self.updateLocalTempLabel(weatherTemp: weather)
                self.updateLocalWeatherImage(weatherCode: weather)
            } else {
                self.showAlert(title: "Error", message: "Weather's data for Paris download failed!")
            }
        }
    }
    //Method to update cities labels
    private func updateCityNameLabel() {
        foreignerCityNameLabel.text = "NEW YORK"
        localCityNameLabel.text = "PARIS"
    }
    //Method to update New York temp label
    private func updateForeignerTempLabel(weatherTemp: Weather) {
        foreignerTemperatureLabel.text = weatherTemp.query.results.channel.item.condition.temp + "°C"
    }
    //Method to update Paris temp label
    private func updateLocalTempLabel(weatherTemp: Weather) {
        localTemperatureLabel.text = weatherTemp.query.results.channel.item.condition.temp + "°C"
    }

    //Method to update foreigner weather image with a forecast icon
    private func updateForeignerWeatherImage(weatherCode: Weather) {
        if let iconForecast = WeatherCode.convertYahooCodeIntoIconForecast(code: weatherCode.query.results.channel.item.condition.code) {
            let foreignerForecastImage = UIImage(named: iconForecast)
            foreignerWeatherImage.image = foreignerForecastImage
        }
    }
    //Method to update local weather image with a forecast icon
    private func updateLocalWeatherImage(weatherCode: Weather) {
        if let iconForecast = WeatherCode.convertYahooCodeIntoIconForecast(code: weatherCode.query.results.channel.item.condition.code) {
            let localForecastImage = UIImage(named: iconForecast)
            localWeatherImage.image = localForecastImage
        }
    }
    //Method to toggle activity indicator when datas for New York are currently downloading
    private func toggleForeignerActivityIndicator(shown: Bool) {
        foreignerActivityIndicator.isHidden = !shown
    }
    //Method to toggle activity indicator when datas for Paris are currently downloading
    private func toggleLocalActivityIndicator(shown: Bool) {
        localActivityIndicator.isHidden = !shown
    }
}
