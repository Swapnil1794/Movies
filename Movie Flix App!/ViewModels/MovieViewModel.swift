//
//  MoviesViewModel.swift
//  Movie Flix App!
//
//  Created by Swapnil Gavali on 12/06/21.
//

import Foundation

struct MovieViewModel {
    
    
    private let movie:Movie
    
    var title:String {
        return movie.title
    }
    var releaseDate:String {
        return movie.releaseDate
    }
    var overview:String {
        return movie.overview
    }
    var posterPath:String {
        return Constants.POSTER_BASE_URL + movie.posterPath
    }
    var backdropPath:String {
        return Constants.BACKDROP_BASE_URL + movie.backdropPath
    }
    var voteCount:Int {
        return movie.voteCount
    }
    
    var id:Int {
        return movie.id
    }
    var isSelected = false
    
    
    init(movie:Movie) {
        self.movie = movie
    }
}
