//
//  DetailViewModel.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 01/05/21.
//

import Foundation
import RxSwift

class DetailViewModel: ObservableObject {
    
    private let disposeBag = DisposeBag()
    private let detailUseCase: DetailUseCase
    
    var movie = PublishSubject<Movie>()
    var casts = PublishSubject<[Cast]>()
    var trailers = PublishSubject<[Video]>()
    var favMovies: Box<[Movie]> = Box([])
    var errorMessage: Box<String> = Box("")
    var loadingState: Box<Bool> = Box(false)
    
    init(detailUseCase: DetailUseCase) {
        self.detailUseCase = detailUseCase
    }
    
    func getDetailMovie(idMovie: Int) {
        self.loadingState.value = true
        detailUseCase.getDetailMovie(idMovie: idMovie)
            .observe(on: MainScheduler.instance)
            .subscribe{ result in
                self.movie.onNext(result)
                self.movie.onCompleted()
            } onError: { error in
                self.errorMessage.value = String(describing: error)
            } onCompleted: {
                self.loadingState.value = false
            }.disposed(by: disposeBag)
    }
    
    func getMovieCast(idMovie: Int) {
        self.loadingState.value = true
        detailUseCase.getMovieCast(idMovie: idMovie)
            .observe(on: MainScheduler.instance)
            .subscribe{ result in
                self.casts.onNext(result)
                self.casts.onCompleted()
            } onError: { error in
                self.errorMessage.value = error.localizedDescription
            } onCompleted: {
                self.loadingState.value = false
            }.disposed(by: disposeBag)
    }
    
    func getMovieTrailer(idMovie: Int)  {
        self.loadingState.value = true
        detailUseCase.getMovieTrailer(idMovie: idMovie)
            .observe(on: MainScheduler.instance)
            .subscribe{ result in
                self.trailers.onNext(result)
                self.trailers.onCompleted()
            } onError: { error in
                self.errorMessage.value = error.localizedDescription
            } onCompleted: {
                self.loadingState.value = false
            }.disposed(by: disposeBag)
    }
    
    func getFavoriteMovie() {
        detailUseCase.getFavoriteMovie()
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.favMovies.value = result
            } onError: { error in
                self.errorMessage.value = String(describing: error)
            }.disposed(by: disposeBag)
    }
    
    func addFavoriteMovie(from movie: Movie) {
        detailUseCase.addFavoriteMovie(from: movie)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                print(result)
            } onError: { error in
                self.errorMessage.value = String(describing: error)
            }.disposed(by: disposeBag)
    }
    
    func removeFavoriteMovie(idMovie: Int) {
        detailUseCase.removeFavoriteMovie(idMovie: idMovie)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                print(result)
            } onError: { error in
                self.errorMessage.value = String(describing: error)
            }.disposed(by: disposeBag)
    }
    
}
