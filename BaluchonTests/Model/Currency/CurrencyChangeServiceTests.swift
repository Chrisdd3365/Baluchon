//
//  CurrencyChangeServiceTests.swift
//  CurrencyChangeServiceTests
//
//  Created by Christophe DURAND on 22/08/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import XCTest
@testable import Baluchon

class CurrencyChangeServiceTests: XCTestCase {
    
    func testGetCurrencyChangeShouldGetFailedCallbackIfError() {
        // Given
        let currencyChangeService = CurrencyChangeService(
            currencySession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        currencyChangeService.getCurrencyChange { (success, currency) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(currency)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetCurrencyChangeShouldGetFailedCallbackIfNoData() {
        // Given
        let currencyChangeService = CurrencyChangeService(
            currencySession: URLSessionFake(data: nil, response: nil, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        currencyChangeService.getCurrencyChange { (success, currency) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(currency)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetCurrencyChangeShouldGetFailedCallbackIfIncorrectResponse() {
        // Given
        let currencyChangeService = CurrencyChangeService(
            currencySession: URLSessionFake(
                data: FakeCurrencyResponseData.currencyCorrectData,
                response: FakeResponseData.responseKO,
                error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        currencyChangeService.getCurrencyChange { (success, currency) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(currency)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetCurrencyChangeShouldGetFailedCallbackIfIncorrectData() {
        // Given
        let currencyChangeService = CurrencyChangeService(
            currencySession: URLSessionFake(
                data: FakeResponseData.incorrectData,
                response: FakeResponseData.responseOK,
                error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        currencyChangeService.getCurrencyChange { (success, currency) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(currency)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetCurrencyChangeShouldGetSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let currencyChangeService = CurrencyChangeService(
            currencySession: URLSessionFake(
                data: FakeCurrencyResponseData.currencyCorrectData,
                response: FakeResponseData.responseOK,
                error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        currencyChangeService.getCurrencyChange { (success, currency) in
            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(currency)

            let rates = [        "AED": 4.299621,
                                 "AFN": 86.076683,
                                 "ALL": 125.988386,
                                 "AMD": 564.893002,
                                 "ANG": 2.159814,
                                 "AOA": 320.63012,
                                 "ARS": 36.231816,
                                 "AUD": 1.592618,
                                 "AWG": 2.098246,
                                 "AZN": 1.995827,
                                 "BAM": 1.957368,
                                 "BBD": 2.343188,
                                 "BDT": 98.22371,
                                 "BGN": 1.956602,
                                 "BHD": 0.44148,
                                 "BIF": 2072.259258,
                                 "BMD": 1.17057,
                                 "BND": 1.76852,
                                 "BOB": 8.071604,
                                 "BRL": 4.774694,
                                 "BSD": 1.167409,
                                 "BTC": 0.000166,
                                 "BTN": 82.09038,
                                 "BWP": 12.381695,
                                 "BYN": 2.413539,
                                 "BYR": 22943.162996,
                                 "BZD": 2.352903,
                                 "CAD": 1.513839,
                                 "CDF": 1891.640646,
                                 "CHF": 1.142722,
                                 "CLF": 0.026452,
                                 "CLP": 768.028274,
                                 "CNY": 7.964207,
                                 "COP": 3444.342345,
                                 "CRC": 666.095042,
                                 "CUC": 1.17057,
                                 "CUP": 31.020093,
                                 "CVE": 110.357756,
                                 "CZK": 25.713671,
                                 "DJF": 208.033804,
                                 "DKK": 7.457032,
                                 "DOP": 58.323622,
                                 "DZD": 137.728662,
                                 "EGP": 20.98621,
                                 "ERN": 17.558828,
                                 "ETB": 32.331719,
                                 "EUR": 1,
                                 "FJD": 2.467736,
                                 "FKP": 0.912921,
                                 "GBP": 0.906612,
                                 "GEL": 2.914509,
                                 "GGP": 0.906945,
                                 "GHS": 5.625522,
                                 "GIP": 0.912892,
                                 "GMD": 56.216625,
                                 "GNF": 10593.595765,
                                 "GTQ": 8.820768,
                                 "GYD": 244.613349,
                                 "HKD": 9.188912,
                                 "HNL": 28.077867,
                                 "HRK": 7.434635,
                                 "HTG": 78.993568,
                                 "HUF": 323.874366,
                                 "IDR": 17113.726684,
                                 "ILS": 4.242958,
                                 "IMP": 0.906945,
                                 "INR": 82.10434,
                                 "IQD": 1396.899161,
                                 "IRR": 49286.830218,
                                 "ISK": 124.747783,
                                 "JEP": 0.906945,
                                 "JMD": 159.923112,
                                 "JOD": 0.830515,
                                 "JPY": 130.007548,
                                 "KES": 117.818019,
                                 "KGS": 80.344727,
                                 "KHR": 4775.387545,
                                 "KMF": 498.768205,
                                 "KPW": 1053.525036,
                                 "KRW": 1294.180298,
                                 "KWD": 0.354447,
                                 "KYD": 0.975553,
                                 "KZT": 423.676362,
                                 "LAK": 9971.613974,
                                 "LBP": 1771.298463,
                                 "LKR": 188.766423,
                                 "LRD": 180.560668,
                                 "LSL": 16.67477,
                                 "LTL": 3.56872,
                                 "LVL": 0.726397,
                                 "LYD": 1.61802,
                                 "MAD": 10.989427,
                                 "MDL": 19.551436,
                                 "MGA": 3898.228097,
                                 "MKD": 61.589542,
                                 "MMK": 1803.493932,
                                 "MNT": 2890.108253,
                                 "MOP": 9.465696,
                                 "MRO": 418.394677,
                                 "MUR": 40.156977,
                                 "MVR": 18.096547,
                                 "MWK": 851.285753,
                                 "MXN": 21.965032,
                                 "MYR": 4.802897,
                                 "MZN": 69.865453,
                                 "NAD": 16.873741,
                                 "NGN": 423.816532,
                                 "NIO": 37.37804,
                                 "NOK": 9.727106,
                                 "NPR": 131.378867,
                                 "NZD": 1.744359,
                                 "OMR": 0.450722,
                                 "PAB": 1.16735,
                                 "PEN": 3.849594,
                                 "PGK": 3.879618,
                                 "PHP": 62.335156,
                                 "PKR": 144.079562,
                                 "PLN": 4.272169,
                                 "PYG": 6796.034447,
                                 "QAR": 4.262051,
                                 "RON": 4.648332,
                                 "RSD": 118.397219,
                                 "RUB": 79.059214,
                                 "RWF": 1030.522601,
                                 "SAR": 4.389928,
                                 "SBD": 9.268043,
                                 "SCR": 15.909796,
                                 "SDG": 21.073701,
                                 "SEK": 10.662378,
                                 "SGD": 1.594667,
                                 "SHP": 1.546207,
                                 "SLL": 10183.954737,
                                 "SOS": 676.003466,
                                 "SRD": 8.730084,
                                 "STD": 24623.563324,
                                 "SVC": 10.243188,
                                 "SYP": 602.843223,
                                 "SZL": 16.605687,
                                 "THB": 38.098547,
                                 "TJS": 11.022789,
                                 "TMT": 4.102846,
                                 "TND": 3.203266,
                                 "TOP": 2.665621,
                                 "TRY": 7.296453,
                                 "TTD": 7.872724,
                                 "TWD": 35.903673,
                                 "TZS": 2671.126293,
                                 "UAH": 32.816333,
                                 "UGX": 4407.486623,
                                 "USD": 1.17057,
                                 "UYU": 37.376408,
                                 "UZS": 9163.681274,
                                 "VEF": 11.691067,
                                 "VND": 27274.094711,
                                 "VUV": 131.661823,
                                 "WST": 3.055505,
                                 "XAF": 656.466632,
                                 "XAG": 0.078391,
                                 "XAU": 0.000966,
                                 "XCD": 3.163522,
                                 "XDR": 0.834558,
                                 "XOF": 656.47924,
                                 "XPF": 119.351447,
                                 "YER": 293.051771,
                                 "ZAR": 16.576549,
                                 "ZMK": 10536.525863,
                                 "ZMW": 12.028731,
                                 "ZWL": 377.338957]

            XCTAssertEqual(rates, currency?.rates)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
