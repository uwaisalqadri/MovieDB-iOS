//
//  LocalDataSource.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 23/08/21.
//

import RxSwift
import RealmSwift

protocol LocalDataSource {
  func getFavoriteMovie() -> Observable<[MovieEntity]>
  func addFavoriteMovie(from movie: MovieEntity)
  func removeFavoriteMovie(from movie: MovieEntity)
}

class DefaultLocalDataSource: LocalDataSource {
  private let realm: Realm?

  init(realm: Realm?) {
    self.realm = realm
  }

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

  func addFavoriteMovie(from movie: MovieEntity) {
    if let realm = self.realm {
      do {
        try realm.write {
          realm.add(movie, update: .all)
        }
      } catch {
        print(DatabaseError.requestFailed)
      }
    } else {
      print(DatabaseError.invalidInstance)
    }
  }

  func removeFavoriteMovie(from movie: MovieEntity) {
    if let realm = self.realm {
      if let movieEntity = {
        realm.objects(MovieEntity.self).filter("id = \(movie.id ?? 0)")
      }().first {
        do {
          try realm.write {
            realm.delete(movieEntity)
          }
        } catch {
          print(DatabaseError.requestFailed)
        }
      }
    } else {
      print(DatabaseError.invalidInstance)
    }
  }
}
