//
//  FakeResponseData.swift
//  BaluchonTests
//
//  Created by Christophe DURAND on 28/08/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import Foundation

class FakeResponseData {
    
    static let currencyIncorrectData = "error".data(using: .utf8)!
    
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!
    
    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!
    
    class CurrencyError: Error {}
    static let error = CurrencyError()
}

class FakeCurrencyResponseData: FakeResponseData {
    static var currencyCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Currency", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
}

class FakeWeatherResponseData: FakeResponseData {
    static var weatherNewYorkCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "WeatherNewYork", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    static var weatherParisCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "WeatherParis", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
}
