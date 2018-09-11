//
//  WeatherViewController.swift
//  Baluchon
//
//  Created by Christophe DURAND on 05/09/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import UIKit

enum Forecast {
    case tornado, thunderstorm, snow, sleet, rain, hail, fog, wind, cloudy, partlyCloudyNight, partlyCloudyDay, clearNight, clearDay, error
}

class WeatherViewController: UIViewController {

    @IBOutlet weak var foreignerCityNameLabel: UILabel!
    @IBOutlet weak var foreignerTemperatureLabel: UILabel!
    @IBOutlet weak var foreignerWeatherImage: UIImageView!
    @IBOutlet weak var localCityNameLabel: UILabel!
    @IBOutlet weak var localTemperatureLabel: UILabel!
    @IBOutlet weak var localWeatherImage: UIImageView!
    
    var weatherService = WeatherService()
    
    static let tornado = ["0", "1", "2"]
    static let thunderstorm = ["3", "4", "37", "38", "39", "45"]
    static let snow = ["5", "7", "13", "14", "15", "16", "41", "42", "43", "46", "47"]
    static let sleet = ["6", "18"]
    static let rain = ["8", "9", "10", "11", "12", "35", "40"]
    static let hail = ["17"]
    static let fog = ["19", "20", "21", "22", "23"]
    static let wind = ["24"]
    static let cloudy = ["26", "44"]
    static let partlyCloudyNight = ["27", "29"]
    static let partlyCloudyDay = ["28", "30"]
    static let clearNight = ["31", "33"]
    static let clearDay = ["32", "34", "36"]
    static let error = ["3200"]
    
    var weather: [(String, [String])] = [("tornado", tornado), ("thunderstorm", thunderstorm), ("snow", snow),("sleet", sleet), ("rain", rain), ("hail", hail), ("fog", fog), ("wind", wind), ("cloudy", cloudy), ("partly-cloudy-night", partlyCloudyNight), ("partly-cloudy-day", partlyCloudyDay), ("clear-night", clearNight), ("clear-day", clearDay), ("error", error)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showWeather()
    }
    
    func showWeather() {
        weatherService.getForeignerWeather(city: .newYork) { (success, weather) in
            if success, let weather = weather {
                self.updateTempLabel(weatherTemp: weather)
                //self.updateIconForecast(weatherCode: weather)
            } else {
                self.showAlert(title: "Error", message: "Weather's data download failed!")
            }
        }
    }

    func updateTempLabel(weatherTemp: WeatherCodeAndTemp) {
        foreignerTemperatureLabel.text = weatherTemp.newYorkTemp + "°C"
        localTemperatureLabel.text = weatherTemp.parisTemp + "°C"
    }
    
//    func updateIconForecast(weatherCode: WeatherCodeAndTemp, forecast: Forecast) {
//        let index = 0
//
//        switch forecast {
//            //case .tornado:
//
//            // case .thunderstorm:
//
//        case .snow:
//            if weather[3] == weather[3] {
//                foreignerWeatherImage.image = #imageLiteral(resourceName: "snow")
//                localWeatherImage.image = #imageLiteral(resourceName: "snow")
//            }
//            //case .sleet:
//
//        case .rain:
//            if weather[index] == weather[5] {
//                foreignerWeatherImage.image = #imageLiteral(resourceName: "rain")
//                localWeatherImage.image = #imageLiteral(resourceName: "rain")
//            }
//            //case .hail:
//
//        case .fog:
//            if weather[index] == weather[7] {
//                foreignerWeatherImage.image = #imageLiteral(resourceName: "fog")
//                localWeatherImage.image = #imageLiteral(resourceName: "fog")
//            }
//        case .wind:
//            if weather[index] == weather[8] {
//                foreignerWeatherImage.image = #imageLiteral(resourceName: "wind")
//                localWeatherImage.image = #imageLiteral(resourceName: "wind")
//            }
//        case .cloudy:
//            if weather[index] == weather[9] {
//                foreignerWeatherImage.image = #imageLiteral(resourceName: "cloudy")
//                localWeatherImage.image = #imageLiteral(resourceName: "cloudy")
//            }
//        case .partlyCloudyNight:
//            if weather[index] == weather[10] {
//                foreignerWeatherImage.image = #imageLiteral(resourceName: "partly-cloudy-night")
//                localWeatherImage.image = #imageLiteral(resourceName: "partly-cloudy-night")
//            }
//        case .partlyCloudyDay:
//            if weather[index] == weather[11] {
//                foreignerWeatherImage.image = #imageLiteral(resourceName: "partly-cloudy-day")
//                localWeatherImage.image = #imageLiteral(resourceName: "partly-cloudy-day")
//            }
//        case .clearNight:
//            if weather[index] == weather[12] {
//                foreignerWeatherImage.image = #imageLiteral(resourceName: "clear-night")
//                localWeatherImage.image = #imageLiteral(resourceName: "clear-night")
//            }
//        case .clearDay:
//            if weather[index] == weather[13] {
//                foreignerWeatherImage.image = #imageLiteral(resourceName: "clear-day")
//                localWeatherImage.image = #imageLiteral(resourceName: "clear-day")
//            }
//        case .error:
//            if weather[index] == weather[14] {
//                foreignerWeatherImage.image = nil
//                localWeatherImage.image = nil
//            }
//        default:
//            break
//        }
//    }
}
