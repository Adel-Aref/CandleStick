//
//  HomeRepo.swift
//  CandleStick
//
//  Created by Adel Aref on 10/10/2022.
//


import Foundation

class ChartRepo: Repository {
    var networkClient: APIRouter
    var cacher: Cacher

    public init(_ client: APIRouter = NetworkClient()) {
        networkClient = client
        cacher = Cacher(destination: .atFolder("ChartRepo"))
    }

    func getChartData(for symbol: String, completion: @escaping RepositoryCompletion) {
        guard let url = Endpoint.getChartData(symbol: symbol).url else { return }
        if let request = makeRequest(url: url, headers: nil, parameters: nil, query: nil, type: .get) {
            getData(withRequest: request,
                    name: String(describing: BaseModel.self),
                    decodingType: [[BaseModel]].self, strategy:
                        .networkOnly, completion: completion)
        }
    }
}

