//
//  Weather.swift
//  Baluchon
//
//  Created by Christophe DURAND on 04/09/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import Foundation

//Yahoo Weather API structure
struct Weather: Decodable {
    let query: WeatherQuery
}

struct WeatherQuery: Decodable {
    let results: WeatherResults
}

struct WeatherResults: Decodable {
    let channel: WeatherChannel
}

struct WeatherChannel: Decodable {
    let item: WeatherItem
}

struct WeatherItem: Decodable {
    let condition: WeatherConditions
}

struct WeatherConditions: Decodable {
    let code: String
    let temp: String
}




