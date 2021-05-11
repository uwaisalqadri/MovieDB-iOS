//
//  ViewModel.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 01/05/21.
//

import Foundation
import RxSwift


class FavoriteViewModel: NSObject {
    
    private let disposeBag = DisposeBag()
    private let favoriteUseCase: FavoriteUseCase
    
    var favMovies = PublishSubject<[Movie]>()
    var errorMessage: Box<String> = Box("")
    
    init(favoriteUseCase: FavoriteUseCase) {
      self.favoriteUseCase = favoriteUseCase
    }
    
    func getFavoriteMovie() {
        favoriteUseCase.getFavoriteMovie()
            .observe(on: MainScheduler.instance)
            .subscribe{ result in
                print("from viewModel directly \(result)")
                self.favMovies.onNext(result)
                self.favMovies.onCompleted()
            } onError: { error in
                self.errorMessage.value = String(describing: error)
            }.disposed(by: disposeBag)
    }
}
