//
//  TemperatureTests.swift
//  CloneWheatherTests
//
//  Created by Andrei Olaru on 24.11.2024.
//

import XCTest
@testable import CloneWheather

final class TemperatureTests: XCTestCase {

    func testConvertTemperatureFromFToC_ShouldSuccessed() throws {
        //Arrange
        let givenValue = Temperature.F(_: 68).valueInCFromF
        let expectedValue = 20
        //Act + Assert
        XCTAssertNotNil(givenValue)
        XCTAssertEqual(givenValue, expectedValue)
    }
    
    func testConvertTemperatureFromCToF_ShouldSuccessed() throws {
        //Arrange
        let givenValue = Temperature.C(_: 20).valueInFFromC
        let expectedValue = 68
        //Act + Assert
        XCTAssertNotNil(givenValue)
        XCTAssertEqual(givenValue, expectedValue)
    }
    
    func testConvertTemperatureFromCToF_ShouldFail() throws {
        //Arrange
        let givenValue = Temperature.C(_: 21).valueInFFromC
        
        let expectedValue = 68
        //Act + Assert
        XCTAssertNotNil(givenValue)
        XCTAssertNotEqual(givenValue, expectedValue)
    }
    
    func testConvertTemperatureFromFToC_ShouldFail() throws {
        //Arrange
        let givenValue = Temperature.F(_: 69).valueInCFromF
        let expectedValue = 20
        //Act + Assert
        XCTAssertNotNil(givenValue)
        XCTAssertNotEqual(givenValue, expectedValue)
    }
    
    func testCelcius_ShouldReturn_Success() throws {
        //Arrange
        let givenValue = Temperature.C(_: 20).celciusString
        let expectedValue = "20°"
        //Act + Assert
        XCTAssertNotNil(givenValue)
        XCTAssertEqual(givenValue, expectedValue)
    }
    
    func testFahrenheit_ShouldReturn_Success() throws {
        //Arrange
        let givenValue = Temperature.F(_: 68).fahrenheitString
        let expectedValue = "68°"
        //Act + Assert
        XCTAssertNotNil(givenValue)
        XCTAssertEqual(givenValue, expectedValue)
    }
    
    func testCelcius_ShouldReturn_Failure() throws {
        //Arrange
        let givenValue = Temperature.C(_: 20).celciusString
        let expectedValue = "2"
        //Act + Assert
        XCTAssertNotNil(givenValue)
        XCTAssertNotEqual(givenValue, expectedValue)
    }
    
    func testFahrenheit_ShouldReturn_Failure() throws {
        //Arrange
        let givenValue = Temperature.F(_: 68).fahrenheitString
        let expectedValue = "64"
        //Act + Assert
        XCTAssertNotNil(givenValue)
        XCTAssertNotEqual(givenValue, expectedValue)
    }
}
