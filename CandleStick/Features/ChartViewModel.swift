//
//  ChartViewModel.swift
//  CandleStick
//
//  Created by Adel Aref on 10/10/2022.
//

import Foundation
import RxSwift

class ChartViewModel: BaseViewModel {
    var isLoading: PublishSubject<Bool> = PublishSubject()
    let isSuccess: PublishSubject<[[BaseModel]]> = PublishSubject()
    var isError: PublishSubject<ErrorMessage> = PublishSubject()
    var disposeBag: DisposeBag = DisposeBag()
    let repository: Repository

    var refreshClousre: (() -> Void)?
    var cachedMovies = [[BaseModel]]() {
        didSet {
            refreshClousre?()
        }
    }

    public init (_ repo: Repository = ChartRepo()) {
        repository = repo
        isSuccess.disposed(by: disposeBag)
        configureDisposeBag()
    }

    func getChartData(for symbol: String ) {
        self.isLoading.onNext(true)
        (repository as? ChartRepo)?.getChartData(for: symbol) { [weak self] (result) in
            guard let self = self else {
                return
            }
            self.isLoading.onNext(false)
            switch result {
            case .success(let data):
                if let data = data as? [[BaseModel]] {
                    self.isSuccess.onNext(data)
                }
            case .failure(let error):
                let error = ErrorMessage(title: "Error", message: error.localizedDescription, action: nil)
                self.isError.onNext(error)
            }
        }
    }
}
