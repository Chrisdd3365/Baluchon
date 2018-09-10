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
    
    var weatherService = WeatherService()
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    
    
    
    
    
}
