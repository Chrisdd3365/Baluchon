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
        showWeather()
    }
    
    //MARK: - Methods
    //Method to call the getForeignerWeather method from WeatherServivce
    private func showWeather() {
        weatherService.getForeignerWeather(city: .newYork) { (success, weather) in
            self.toggleActivityIndicator(shown: true)
            if success, let weather = weather {
                self.toggleActivityIndicator(shown: false)
                self.updateTempLabel(weatherTemp: weather)
                self.updateForeignerWeatherImage(weatherCode: weather)
                self.updateLocalWeatherImage(weatherCode: weather)
            } else {
                self.showAlert(title: "Error", message: "Weather's data download failed!")
            }
        }
    }
    //Method to update cities labels
    private func updateCityNameLabel() {
        foreignerCityNameLabel.text = "NEW YORK"
        localCityNameLabel.text = "PARIS"
    }
    //Method to update temp labels
    private func updateTempLabel(weatherTemp: WeatherCodeAndTemp) {
        foreignerTemperatureLabel.text = weatherTemp.newYorkTemp + "°C"
        localTemperatureLabel.text = weatherTemp.parisTemp + "°C"
    }
    //Method to update foreigner weather image with a forecast icon
    private func updateForeignerWeatherImage(weatherCode: WeatherCodeAndTemp) {
        if let iconForecast = WeatherCode.convertYahooCodeIntoIconForecast(code: weatherCode.newYorkCode) {
            let foreignerForecastImage = UIImage(named: iconForecast)
            foreignerWeatherImage.image = foreignerForecastImage
        }
    }
    //Method to update local weather image with a forecast icon
    private func updateLocalWeatherImage(weatherCode: WeatherCodeAndTemp) {
        if let iconForecast = WeatherCode.convertYahooCodeIntoIconForecast(code: weatherCode.parisCode) {
            let localForecastImage = UIImage(named: iconForecast)
            localWeatherImage.image = localForecastImage
        }
    }
    //Method to toggle activity indicator when datas are currently downloading
    private func toggleActivityIndicator(shown: Bool) {
        foreignerActivityIndicator.isHidden = !shown
        localActivityIndicator.isHidden = !shown
    }
}
