//
//  ChartModel.swift
//  CandleStick
//
//  Created by Adel Aref on 10/10/2022.
//

import Foundation

enum BaseModel: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(BaseModel.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for BaseModel"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

enum ChartDataType {
    case openTime(Double)
    case open(Double)
    case high(Double)
    case low(Double)
    case close(Double)
    case volume(Double)
}

struct ChartDataModel {
    let data: [[ChartDataType]]

    init(with data: [[BaseModel]]) {
        var array: [[ChartDataType]] = []
        data.forEach { model in
            var arrayGrapheDataType: [ChartDataType] = []
            for (index, item) in model.enumerated() {
                switch index {
                case 0:
                    switch item {
                    case .integer(let integer):
                        arrayGrapheDataType.append(ChartDataType.openTime(Double(integer)))
                    case .string(let string):
                        arrayGrapheDataType.append(ChartDataType.openTime(Double(string) ?? 0.0))
                    }
                case 1:
                    switch item {
                    case .integer(let integer):
                        arrayGrapheDataType.append(ChartDataType.open(Double(integer)))
                    case .string(let string):
                        arrayGrapheDataType.append(ChartDataType.open(Double(string) ?? 0.0))
                    }
                case 2:
                    switch item {
                    case .integer(let integer):
                        arrayGrapheDataType.append(ChartDataType.high(Double(integer)))
                    case .string(let string):
                        arrayGrapheDataType.append(ChartDataType.high(Double(string) ?? 0.0))
                    }
                case 3:
                    switch item {
                    case .integer(let integer):
                        arrayGrapheDataType.append(ChartDataType.low(Double(integer)))
                    case .string(let string):
                        arrayGrapheDataType.append(ChartDataType.low(Double(string) ?? 0.0))
                    }
                case 4:
                    switch item {
                    case .integer(let integer):
                        arrayGrapheDataType.append(ChartDataType.close(Double(integer)))
                    case .string(let string):
                        arrayGrapheDataType.append(ChartDataType.close(Double(string) ?? 0.0))
                    }
                case 5:
                    switch item {
                    case .integer(let integer):
                        arrayGrapheDataType.append(ChartDataType.volume(Double(integer)))
                    case .string(let string):
                        arrayGrapheDataType.append(ChartDataType.volume(Double(string) ?? 0.0))
                    }
                default:
                    break
                }
            }
            array.append(arrayGrapheDataType)
        }
        self.data = array
    }
}
