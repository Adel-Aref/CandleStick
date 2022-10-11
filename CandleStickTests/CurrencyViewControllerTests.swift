//
//  CurrencyViewControllerTests.swift
//  CandleStickTests
//
//  Created by Adel Aref on 10/10/2022.
//

import Foundation
import XCTest
@testable import CandleStick

class CurrencyViewControllerTests: XCTestCase {
    var sut: CurrencyViewModel? // system under test
    override func setUpWithError() throws {
        sut = CurrencyViewModel()
    }

    func testNumOfItems() {
        XCTAssertEqual(sut?.numOfItems, 3)
    }

    func testGetCurrencyByIndex() {
        XCTAssertEqual(sut?.getCurrencyText(for: 0), "BTCUSDT")
        XCTAssertNotEqual(sut?.getCurrencyText(for: 1), "ETHUSDT")
    }

}
