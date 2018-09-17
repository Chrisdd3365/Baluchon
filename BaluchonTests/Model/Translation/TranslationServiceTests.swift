//
//  TranslationServiceTests.swift
//  BaluchonTests
//
//  Created by Christophe DURAND on 13/09/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import XCTest
@testable import Baluchon

class TranslationServiceTests: XCTestCase {

    func testGetTranslationShouldGetFailedCallbackIfError() {
        // Given
        let translationService = TranslationService(
            translationSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translationService.getTranslation(text: "salut") { (success, translation) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetTranslationShouldGetFailedCallback() {
        // Given
        let translationService = TranslationService(
            translationSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translationService.getTranslation(text: "salut") { (success, translation) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetTranslationChangeShouldGetFailedCallbackIfNoData() {
        // Given
        let translationService = TranslationService(
            translationSession: URLSessionFake(data: nil, response: nil, error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translationService.getTranslation(text: "salut") { (success, translation) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetTranslationShouldGetFailedCallbackIfIncorrectResponse() {
        // Given
        let translationService = TranslationService(
            translationSession: URLSessionFake(
                data: FakeTranslationResponseData.translationCorrectData,
                response: FakeResponseData.responseKO,
                error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translationService.getTranslation(text: "salut") { (success, translation) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetTranslationChangeShouldGetFailedCallbackIfIncorrectData() {
        // Given
        let translationService = TranslationService(
            translationSession: URLSessionFake(
                data: FakeResponseData.incorrectData,
                response: FakeResponseData.responseOK,
                error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translationService.getTranslation(text: "salut") { (success, translation) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetTranslationShouldGetSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let translationService = TranslationService(
            translationSession: URLSessionFake(
                data: FakeTranslationResponseData.translationCorrectData,
                response: FakeResponseData.responseOK,
                error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translationService.getTranslation(text: "salut") { (success, translation) in
            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(translation)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
