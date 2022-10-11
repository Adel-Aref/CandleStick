//
//  Repository.swift
//  CandleStick
//
//  Created by Adel Aref on 10/10/2022.
//

import Foundation
import UIKit
import Alamofire
// swiftlint:disable all
protocol Repository {
    var networkClient: APIRouter { get }
    var cacher: Cacher { get }
    func getData<T: Codable>(withRequest: URLRequest,
                              name: String?,
                              decodingType: T.Type,
                              strategy: Strategy,
                              completion: @escaping RepositoryCompletion)
}

extension Repository {
    typealias RepositoryCompletion = (RequestResult<Codable, RequestError>) -> Void
    func getData<T: Codable>(withRequest: URLRequest,
                              name: String?,
                              decodingType: T.Type,
                              strategy: Strategy = .networkOnly,
                              completion: @escaping RepositoryCompletion) {

        switch strategy {
        case .networkOnly:
            print("network")
        case .offlineOnly:
            // here we can use caching
            break
        case .offlineFirstFile:
            // here we can use caching
            break
        default:
            print("default")
        }
        networkClient.makeRequest(withRequest: withRequest, decodingType: decodingType) { (result) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(.timeOut):
                showAlertConnectionError(withMessege: "The request timed out.")
            case .failure(.connectionError):
                completion(.failure(.connectionError))
            case .failure(.jsonConversionFailure):
                completion(.failure(.jsonConversionFailure))
            default :
                return
            }
            completion(result)
        }
    }
}
func showAlertConnectionError(withMessege: String) {
    let alertController =
        UIAlertController(title: nil, message: withMessege, preferredStyle: UIAlertController.Style.alert)
    let okAction =
        UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil)
    alertController.addAction(okAction)
    UIApplication.getTopViewController()?.present(alertController, animated: true, completion: nil)
}
