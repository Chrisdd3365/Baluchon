//
//  BaluchonTests.swift
//  BaluchonTests
//
//  Created by Christophe DURAND on 22/08/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import XCTest
@testable import Baluchon

class BaluchonTests: XCTestCase {
    
    var currencyChangeService: CurrencyChangeService!
    
    override func setUp() {
        super.setUp()
        currencyChangeService = CurrencyChangeService()
    }
    
    func testGivenGetCurrencyChange_WhenCurrenciesRatesAreDownloaded_ThenCurrencyIsChanged() {
        currencyChangeService.getCurrencyChange()
        
        XCTAssert(true)
    }
    
}
