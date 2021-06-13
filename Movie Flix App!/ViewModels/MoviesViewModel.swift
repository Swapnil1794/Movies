//
//  MoviesViewModel.swift
//  Movie Flix App!
//
//  Created by Swapnil Gavali on 12/06/21.
//

import Foundation
enum Mode {
    case view
    case selected
}

class MoviesViewModel {
    
    let title = "Movies"
    var movieViewModels:[MovieViewModel] = []
    var originalMovieViewModels:[MovieViewModel] = []
    
    var didDataChanged:Box<Bool> = Box(false)
    var mode:Box<Mode> = Box(.view)
    
    private var service:APIServiceProtocol?
    
    init(service:APIServiceProtocol = APIService()) {
        self.service = service
        fetchMovies(requestModel:RequestModel(apiKey: Constants.API_KEY))
    }
    
    func fetchMovies(requestModel:RequestModel) {
        let parameters = requestModel.dictionary ?? [:]
        
        service?.fetch(api:Constants.VERSION_3,controller:Constants.MOVIE,action:Constants.NOW_PLAYING, parameters: parameters) { [weak self] ( result:ResponceModel?)  in
            if let result = result {
                self?.movieViewModels = result.movies?.map({
                    return MovieViewModel(movie: $0)
                }) ?? []
                self?.originalMovieViewModels = self?.movieViewModels ?? []
                self?.didDataChanged.value = true
            }else{
                
            }
            
        }
    }
    
    
    func getSelectedIndexPaths() -> [IndexPath] {
        var indexPathArray:[IndexPath] = []
        for i in 0 ..< movieViewModels.count {
            if movieViewModels[i].isSelected {
                indexPathArray.append(IndexPath(row: i, section: 0))
            }
        }
        originalMovieViewModels.removeAll { movieViewModel in
            for model in movieViewModels {
                if model.id == movieViewModel.id && model.isSelected == true {
                    return true
                }
            }
            return false
        }
        
        movieViewModels.removeAll { movieViewModel in
            return movieViewModel.isSelected == true ? true : false
        }
        return indexPathArray
    }
    
    func getFilteredMovies(string:String) {
        self.movieViewModels.removeAll()
        for movieViewModel in originalMovieViewModels {
            if movieViewModel.title.lowercased().contains(string.lowercased()) {
                self.movieViewModels.append(movieViewModel)
            }
        }
        
        if string.isEmpty {
            self.movieViewModels = self.originalMovieViewModels
        }
        didDataChanged.value = true
    }
     
}


