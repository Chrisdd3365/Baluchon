//
//  WeatherServiceTests.swift
//  BaluchonTests
//
//  Created by Christophe DURAND on 07/09/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import XCTest

class WeatherServiceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
//    func testGetWeatherShouldGetFailedCallbackIfError() {
//        // Given
//        let weatherService = WeatherService(
//            weatherSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
//
//        // When
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        WeatherService.getWeather { (success, weather) in
//            // Then
//            XCTAssertFalse(success)
//            XCTAssertNil(weather)
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 0.01)
//    }
//
//    func testGetWeatherShouldGetFailedCallback() {
//        // Given
//        let weatherService = WeatherService(
//            weatherSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
//
//        // When
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        weatherService.getWeather { (success, weather) in
//            // Then
//            XCTAssertFalse(success)
//            XCTAssertNil(weather)
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 0.01)
//    }
//
//    func testGetWeatherShouldGetFailedCallbackIfNoData() {
//        // Given
//        let weatherService = WeatherService(
//            weatherSession: URLSessionFake(data: nil, response: nil, error: nil))
//
//        // When
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        weatherService.getWeather { (success, weather) in
//            // Then
//            XCTAssertFalse(success)
//            XCTAssertNil(weather)
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 0.01)
//    }
//
//    func testGetWeatherShouldGetFailedCallbackIfIncorrectResponse() {
//        // Given
//        let weatherService = WeatherService(
//            weatherSession: URLSessionFake(
//                data: FakeWeatherResponseData.weatherCorrectData,
//                response: FakeResponseData.responseKO,
//                error: nil))
//
//        // When
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        weatherService.getWeather { (success, weather) in
//            // Then
//            XCTAssertFalse(success)
//            XCTAssertNil(weather)
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 0.01)
//    }
//
//    func testGetWeatherShouldGetFailedCallbackIfIncorrectData() {
//        // Given
//        let weatherService = WeatherService(
//            weatherSession: URLSessionFake(
//                data: FakeResponseData.currencyIncorrectData,
//                response: FakeResponseData.responseOK,
//                error: nil))
//
//        // When
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        weatherService.getWeather { (success, weather) in
//            // Then
//            XCTAssertFalse(success)
//            XCTAssertNil(weather)
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 0.01)
//    }
//
//    func testGetWeatherShouldGetSuccessCallbackIfNoErrorAndCorrectData() {
//        // Given
//        let weatherChangeService = WeatherService(
//            weatherSession: URLSessionFake(
//                data: FakeWeatherResponseData.weatherCorrectData,
//                response: FakeResponseData.responseOK,
//                error: nil))
//
//        // When
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        weatherService.getWeather { (success, weather) in
//            // Then
//            XCTAssertTrue(success)
//            XCTAssertNotNil(weather)
//
//            let tempNewYork = "74"
//            let tempParis = "62"
//            let codeNewYork = "26"
//            let codeParis = "26"
//
//            XCTAssertEqual(tempNewYork, weather.temp)
//            XCTAssertEqual(tempParis, weather.temp)
//            XCTAssertEqual(codeNewYork, weather.code)
//            XCTAssertEqual(codeParis, weather.code)
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 0.01)
//    }
}
