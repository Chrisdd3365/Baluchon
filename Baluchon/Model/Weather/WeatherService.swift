//
//  WeatherService.swift
//  Baluchon
//
//  Created by Christophe DURAND on 07/09/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import Foundation

//Enumeration named City
enum City: String {
    case newYork
    case paris
}

class WeatherService {
    
    //MARK: - Properties
    var task: URLSessionDataTask?
    private var weatherSession: URLSession
    
    init(weatherSession: URLSession = URLSession(configuration: .default)) {
        self.weatherSession = weatherSession
    }
    
    //MARK: - Methods
    //Method to retrieve url of Yahoo Weather API
    private func urlWeather(city: City) -> String {
        let weatherURL = YahooAPI.query + city.rawValue + YahooAPI.endQuery
        guard let weatherURLconverted = weatherURL.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return "" }
        let urlWeather = YahooAPI.baseURL + weatherURLconverted + YahooAPI.format
        return urlWeather
    }
    //Method to get the foreigner's city weather from the Yahoo Weather API with a GET request
    func getWeather(city: City, callback: @escaping (Bool, Weather?) -> Void) {
        guard let url = URL(string: urlWeather(city: city)) else { return }
        task?.cancel()
        task = weatherSession.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let weatherResponseJSON = try? JSONDecoder().decode(Weather.self, from: data) else {
                    callback(false, nil)
                    return
                }
                callback(true, weatherResponseJSON)
            }
        }
        task?.resume()
    }
}
