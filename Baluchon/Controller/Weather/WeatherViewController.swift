//
//  WeatherViewController.swift
//  Baluchon
//
//  Created by Christophe DURAND on 05/09/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var foreignerCityName: UILabel!
    @IBOutlet weak var foreignerTemperature: UILabel!
    @IBOutlet weak var foreignerWeatherImage: UIImageView!
    @IBOutlet weak var localCityName: UILabel!
    @IBOutlet weak var localTemperature: UILabel!
    @IBOutlet weak var localWeatherImage: UIImageView!
    
    func weather() {
        WeatherService.shared.getWeatherForeignerCountry { (success, foreignerWeather) in
            if success, let foreignerWeather =  foreignerWeather {
                
            } else {
                self.showAlert(title: "Error", message: "Weather's data download failed!")
            }
        }
    }
    
    func updateWeather(foreignerWeather: Weather) {
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    
    
    
    
    
}
