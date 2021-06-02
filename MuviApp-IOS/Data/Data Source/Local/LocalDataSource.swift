//
//  LocaleDataSource.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 01/05/21.
//

import Foundation
import RealmSwift
import RxSwift


protocol LocalDataSource {

  func getFavoriteMovie() -> Observable<[MovieEntity]>

  func addFavoriteMovie(from movie: MovieEntity) -> Observable<Bool>

  func removeFavoriteMovie(idMovie: Int) -> Observable<Bool>
}

class DefaultLocalDataSource: NSObject {

  private let realm: Realm?
  private init(realm: Realm?) {
    self.realm = realm
  }

  static let sharedInstance: (Realm?) -> DefaultLocalDataSource = { realmDatabase in
    return DefaultLocalDataSource(realm: realmDatabase)
  }
}

extension DefaultLocalDataSource: LocalDataSource {

  func getFavoriteMovie() -> Observable<[MovieEntity]> {
    return Observable<[MovieEntity]>.create { observer in
      if let realm = self.realm {
        let movies: Results<MovieEntity> = {
          realm.objects(MovieEntity.self)
            .sorted(byKeyPath: "title", ascending: true)
        }()
        observer.onNext(movies.toArray(ofType: MovieEntity.self))
        observer.onCompleted()
      } else {
        observer.onError(DatabaseError.invalidInstance)
      }
      return Disposables.create()
    }
  }

  func addFavoriteMovie(from movie: MovieEntity) -> Observable<Bool> {
    return Observable<Bool>.create { observer in
      if let realm = self.realm {
        do {
          try realm.write {
            realm.add(movie, update: .all)
          }
          observer.onNext(true)
          observer.onCompleted()
        } catch {
          observer.onError(DatabaseError.requestFailed)
        }
      } else {
        observer.onError(DatabaseError.invalidInstance)
      }
      return Disposables.create()
    }
  }

  func removeFavoriteMovie(idMovie: Int) -> Observable<Bool> {
    return Observable<Bool>.create { observer in
      if let realm = self.realm {
        if let movieEntity = {
          realm.objects(MovieEntity.self).filter("id = \(idMovie)")
        }().first {
          do {
            try realm.write {
              realm.delete(movieEntity)
            }
            observer.onNext(true)
            observer.onCompleted()
          } catch {
            observer.onError(DatabaseError.requestFailed)
          }
        }
      } else {
        observer.onError(DatabaseError.invalidInstance)
      }
      return Disposables.create()
    }
  }


}
