//
//  WeatherServiceTests.swift
//  BaluchonTests
//
//  Created by Christophe DURAND on 07/09/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import XCTest
@testable import Baluchon

class WeatherServiceTests: XCTestCase {
        
    func testGetWeatherShouldGetFailedCallbackIfError() {
        // Given
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(city: .paris) { (success, weather) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldGetFailedCallbackIfNoData() {
        // Given
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(city: .paris) { (success, weather) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldGetFailedCallbackIfIncorrectResponse() {
        // Given
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(
                data: FakeWeatherResponseData.weatherNewYorkCorrectData,
                response: FakeResponseData.responseKO,
                error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(city: .paris) { (success, weather) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldGetFailedCallbackIfIncorrectData() {
        // Given
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(
                data: FakeResponseData.incorrectData,
                response: FakeResponseData.responseOK,
                error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(city: .paris) { (success, weather) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldGetSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(
                data: FakeWeatherResponseData.weatherNewYorkCorrectData,
                response: FakeResponseData.responseOK,
                error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(city: .newYork) { (success, weather) in
            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(weather)

            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testConvertYahooCodeIntoIconForecastWhenRetrievingCodeFromYahooAPIThenDisplayForecastIcon() {
        let weatherCode = WeatherCode.convertYahooCodeIntoIconForecast(code: "26")
        
        XCTAssertNotNil(weatherCode)
    }
}
