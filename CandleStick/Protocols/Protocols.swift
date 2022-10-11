//
//  Protocols.swift
//  CandleStick
//
//  Created by Adel Aref on 10/10/2022.
//

import Foundation
import RxSwift

protocol BaseViewModel {
    var isLoading: PublishSubject<Bool> { get }
    var isError: PublishSubject<ErrorMessage> { get }
    var disposeBag: DisposeBag { get }
}

extension BaseViewModel {
    func configureDisposeBag() {
        isError.disposed(by: disposeBag)
        isLoading.disposed(by: disposeBag)
    }
}
protocol BaseViewController {
    var disposeBag: DisposeBag { get }
}
