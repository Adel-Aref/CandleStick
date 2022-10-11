//
//  AbjjadResponse.swift
//  CandleStick
//
//  Created by Adel Aref on 10/10/2022.
//

import Foundation

// swiftlint:disable all
struct AbjjadResponse<T: Codable>: Codable, Cachable {
    var fileName: String? = String(describing: T.self)
    var error: ResponseException?
    var status: Int?
    var results: T?
}

struct ResponseException: Codable {
    var exceptionMessage: String?
}

