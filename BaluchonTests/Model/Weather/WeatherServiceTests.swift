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
        
    override func setUp() {
        super.setUp()
    }
    
    func testGetForeignerWeatherShouldGetFailedCallback() {
        // Given
        let weatherService = WeatherService(
            weatherForeignerSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error),
            weatherLocalSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getForeignerWeather { (success, weather) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetForeignerWeatherShouldGetFailedCallbackIfNoData() {
        // Given
        let weatherService = WeatherService(
            weatherForeignerSession: URLSessionFake(data: nil, response: nil, error: nil),
            weatherLocalSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getForeignerWeather { (success, weather) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetForeignerWeatherShouldGetFailedCallbackIfIncorrectResponse() {
        // Given
        let weatherService = WeatherService(
            weatherForeignerSession: URLSessionFake(
                data: FakeWeatherResponseData.weatherNewYorkCorrectData,
                response: FakeResponseData.responseKO,
                error: nil),
            weatherLocalSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getForeignerWeather { (success, weather) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetForeignerWeatherShouldGetFailedCallbackIfIncorrectData() {
        // Given
        let weatherService = WeatherService(
            weatherForeignerSession: URLSessionFake(
                data: FakeResponseData.incorrectData,
                response: FakeResponseData.responseOK,
                error: nil),
            weatherLocalSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
       weatherService.getForeignerWeather { (success, weather) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetLocalWeatherShouldGetFailedCallbackIfIncorrectData() {
        // Given
        let weatherService = WeatherService(
            weatherForeignerSession: URLSessionFake(data: nil, response: nil, error: nil),
            weatherLocalSession: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getLocalWeather { (success, weather) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetForeignerWeatherShouldGetFailedNotificationIfNoLocalData() {
        // Given
        let weatherService = WeatherService(
            weatherForeignerSession: URLSessionFake(
                data: FakeWeatherResponseData.weatherNewYorkCorrectData,
                response: FakeResponseData.responseOK,
                error: FakeResponseData.error),
            weatherLocalSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getForeignerWeather { (success, weather) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetForeignerWeatherShouldGetFailedNotificationIfErrorWhileRetrievingLocalWeather() {
        // Given
        let weatherService = WeatherService(
            weatherForeignerSession: URLSessionFake(
                data: FakeWeatherResponseData.weatherNewYorkCorrectData,
                response: FakeResponseData.responseOK,
                error: nil),
            weatherLocalSession: URLSessionFake(
                data: FakeWeatherResponseData.weatherParisCorrectData,
                response: FakeResponseData.responseOK,
                error: FakeResponseData.error))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getForeignerWeather { (success, weather) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetForeignerWeatherShouldGetNotificationIfIncorrectResponseWhileRetrievingLocalWeather() {
        // Given
        let weatherService = WeatherService(
            weatherForeignerSession: URLSessionFake(
                data: FakeWeatherResponseData.weatherNewYorkCorrectData,
                response: FakeResponseData.responseOK,
                error: nil),
            weatherLocalSession: URLSessionFake(
                data: FakeWeatherResponseData.weatherParisCorrectData,
                response: FakeResponseData.responseKO,
                error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getForeignerWeather { (success, weather) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetForeignerWeatherShouldGetSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let weatherService = WeatherService(
            weatherForeignerSession: URLSessionFake(
                data: FakeWeatherResponseData.weatherNewYorkCorrectData,
                response: FakeResponseData.responseOK,
                error: nil),
            weatherLocalSession: URLSessionFake(
                data: FakeWeatherResponseData.weatherParisCorrectData,
                response: FakeWeatherResponseData.responseOK,
                error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getForeignerWeather { (success, weather) in
            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(weather)

            let tempNewYork = "74"
            let tempParis = "62"
            let codeNewYork = "26"
            let codeParis = "26"

            XCTAssertEqual(tempNewYork, weather?.newYorkTemp)
            XCTAssertEqual(tempParis, weather?.parisTemp)
            XCTAssertEqual(codeNewYork, weather?.newYorkCode)
            XCTAssertEqual(codeParis, weather?.parisCode)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
