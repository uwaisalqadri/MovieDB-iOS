//
//  PopularViewModel.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 01/05/21.
//

import Foundation
import RxSwift
import RxCocoa

class PopularViewModel: ObservableObject {
    
    private let disposeBag = DisposeBag()
    private let popularUseCase: PopularUseCase
    
    var movies = PublishSubject<[Movie]>()
    var search = PublishRelay<String>()
    var errorMessage: Box<String> = Box("")
    var loadingState: Box<Bool> = Box(false)
    
    init(popularUseCase: PopularUseCase) {
      self.popularUseCase = popularUseCase
    }
    
    func searchMovies(query: String) {
        self.loadingState.value = true
        popularUseCase.searchMovies(query: query)
            .observe(on: MainScheduler.instance)
            .subscribe{ result in
                print("search result \(result)")
                self.movies.onNext(result)
                self.movies.onCompleted()
            } onError: { error in
                self.errorMessage.value = String(describing: error)
            } onCompleted: {
                self.loadingState.value = false
            }.disposed(by: disposeBag)
    }
}
