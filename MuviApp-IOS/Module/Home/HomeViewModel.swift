//
//  HomeViewModel.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 01/05/21.
//

import Foundation
import RxSwift


class HomeViewModel: ObservableObject {
    
    private let disposeBag = DisposeBag()
    private let movieUseCase: MovieUseCase
    
    var popularMovies = PublishSubject<[Movie]>()
    var upComingMovies = PublishSubject<[Movie]>()
    var errorMessage: Box<String> = Box("")
    var loadingState: Box<Bool> = Box(false)
    
    init(movieUseCase: MovieUseCase) {
      self.movieUseCase = movieUseCase
    }
    
    func getDiscoverMovies(year: String) {
        self.loadingState.value = true
        movieUseCase.getDiscoverMovies(year: year)
            .observe(on: MainScheduler.instance)
            .subscribe{ result in
                self.popularMovies.onNext(result)
                self.popularMovies.onCompleted()
            } onError: { error in
                self.errorMessage.value = error.localizedDescription
            } onCompleted: {
                self.loadingState.value = false
            }.disposed(by: disposeBag)
    }
    
    func getUpComingMovies(year: String) {
        self.loadingState.value = true
        movieUseCase.getDiscoverMovies(year: year)
            .observe(on: MainScheduler.instance)
            .subscribe{ result in
                self.upComingMovies.onNext(result)
                self.upComingMovies.onCompleted()
            } onError: { error in
                self.errorMessage.value = error.localizedDescription
            } onCompleted: {
                self.loadingState.value = false
            }.disposed(by: disposeBag)
    }
}
