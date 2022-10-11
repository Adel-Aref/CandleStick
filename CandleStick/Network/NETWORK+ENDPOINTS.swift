//
//  NETWORK+ENDPOINTS.swift
//  CandleStick
//
//  Created by Adel Aref on 10/10/2022.
//

import Foundation

extension Endpoint {
    static func getChartData(time: String = "4h", symbol: String, limit: String = "100") -> Endpoint {
        let path = "/klines?symbol=\(symbol)&interval=\(time)&lim=\(limit)"
        return Endpoint(base: Environment.baseURL, path: path)
    }
}
