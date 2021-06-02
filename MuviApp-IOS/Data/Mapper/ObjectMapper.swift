//
//  MovieMapper.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 01/05/21.
//

import Foundation

final class ObjectMapper {
    
    static func mapMoviesResponseToDomain(
        input movieResponse: [MovieItem]
    ) -> [Movie] {
        return movieResponse.map { result in
            return Movie(
                adult: result.adult,
                backdrop_path: result.backdrop_path,
                genres: result.genres,
                id: result.id,
                original_language: result.original_language,
                original_title: result.original_title,
                overview: result.overview,
                popularity: result.popularity,
                poster_path: result.poster_path,
                release_date: result.release_date,
                title: result.title,
                video: result.video,
                vote_average: result.vote_average,
                vote_count: result.vote_count
            )
        }
    }
    
    static func mapMovieResponseToDomain(
        input movieItem: MovieItem
    ) -> Movie {
        return Movie(
            adult: movieItem.adult,
            backdrop_path: movieItem.backdrop_path,
            genres: movieItem.genres,
            id: movieItem.id,
            original_language: movieItem.original_language,
            original_title: movieItem.original_title,
            overview: movieItem.overview,
            popularity: movieItem.popularity,
            poster_path: movieItem.poster_path,
            release_date: movieItem.release_date,
            title: movieItem.title,
            video: movieItem.video,
            vote_average: movieItem.vote_average,
            vote_count: movieItem.vote_count
        )
    }
    
    static func mapVideoResponseToDomain(
        input videoResponse: [VideoItem]
    ) -> [Video] {
        return videoResponse.map { videoItem in
            return Video(id: videoItem.id, key: videoItem.key, name: videoItem.name, site: videoItem.site, size: videoItem.size, type: videoItem.type)
        }
    }
    
    static func mapCastResponseToDomain(
        input castResponse: [CastItem]
    ) -> [Cast] {
        castResponse.map { castItem in
            return Cast(adult: castItem.adult, cast_id: castItem.cast_id, character: castItem.character, credit_id: castItem.credit_id, gender: castItem.gender, id: castItem.id, known_for_department: castItem.known_for_department, name: castItem.name, order: castItem.order, original_name: castItem.original_name, popularity: castItem.popularity, profile_path: castItem.profile_path ?? Constants.placeHolder)
        }
    }
    
    static func mapMovieEntitiesToDomains(
        input movieEntity: [MovieEntity]
    ) -> [Movie] {
        return movieEntity.map { entity in
            return Movie(adult: entity.adult, backdrop_path: entity.backdrop_path, genres: nil, id: entity.id, original_language: entity.original_language, original_title: entity.original_title, overview: entity.overview, popularity: entity.popularity, poster_path: entity.poster_path, release_date: entity.release_date, title: entity.title, video: entity.video, vote_average: entity.vote_average, vote_count: entity.vote_count)
        }
    }
    
    static func mapMovieDomainToEntity(
        input movie: Movie
    ) -> MovieEntity {
        let entity = MovieEntity()
        entity.adult = movie.adult
        entity.backdrop_path = movie.backdrop_path
        entity.id = movie.id
        entity.original_language = movie.original_language
        entity.original_title = movie.original_title
        entity.overview = movie.overview
        entity.popularity = movie.popularity
        entity.poster_path = movie.poster_path
        entity.release_date = movie.release_date
        entity.title = movie.title
        entity.video = movie.video
        entity.vote_average = movie.vote_average
        entity.vote_count = movie.vote_count
        return entity
    }
}
