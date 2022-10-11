//
//  CurrencyViewModel.swift
//  CandleStick
//
//  Created by Adel Aref on 09/10/2022.
//

import Foundation

class CurrencyViewModel {

    let currencies = ["BTCUSDT", "LTCUSDT", "ETHUSDT"]

    var numOfItems: Int {
        return currencies.count
    }

    func  getCurrencyText(for row: Int) -> String {
        return currencies[row]
    }
}
