//
//  FakeResponseData.swift
//  BaluchonTests
//
//  Created by Christophe DURAND on 28/08/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import Foundation

class FakeResponseData {
    
    static var currencyCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Currency", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    static let currencyIncorrectData = "on est de la merde".data(using: .utf8)!
    
    static let responseOK = HTTPURLResponse(
        url: URL(string: "http://data.fixer.io/api/latest?access_key=2e4288a2049e923be5767c9bacf7ae2a")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!
    
    static let responseKO = HTTPURLResponse(
        url: URL(string: "http://data.fixer.io/api/latest?access_key=2e4288a2049e923be5767c9bacf7ae2a")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!
    
    class CurrencyError: Error {}
    static let error = CurrencyError()
}
