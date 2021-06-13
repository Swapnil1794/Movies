//
//  MovieDetailsViewController.swift
//  Movie Flix App!
//
//  Created by Swapnil Gavali on 12/06/21.
//

import UIKit

class MovieDetailsViewController: UIViewController & Coordinating {
    
    var coordinator: Coordinator?
    var movieViewModel:MovieViewModel?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: CustomImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = movieViewModel?.title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let movie = movieViewModel {
            titleLabel.text = movie.title
            releaseDateLabel.text = "Release Date : \(movie.releaseDate)"
            overviewLabel.text = movie.overview
            posterImageView.loadImageUsingUrlString(urlString: Constants.BACKDROP_BASE_URL + movie.backdropPath)
        }else{
            titleLabel.text = ""
            releaseDateLabel.text = ""
            overviewLabel.text = ""
            posterImageView.image = nil
        }
    }
    
    static func instantiate() -> MovieDetailsViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateViewController(identifier: "MovieDetailsViewController")
        return vc as! MovieDetailsViewController
    }

  

}
