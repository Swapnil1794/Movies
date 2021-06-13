//
//  UnPopularMoviesCell.swift
//  Movie Flix App!
//
//  Created by Swapnil Gavali on 11/06/21.
//

import UIKit

class UnPopularMovieCell: UICollectionViewCell {
    
    var movieViewModel:MovieViewModel! {
        didSet{
            imageView.loadImageUsingUrlString(urlString:movieViewModel.posterPath)
            titleLabel.text = movieViewModel.title
            overviewLabel.text = movieViewModel.overview
            selectView.isHidden = true
            selectImageView.isHidden = true
        }
    }
    
    @IBOutlet weak var imageView: CustomImageView!{
        didSet{
            self.imageView.layer.cornerRadius = 10
            self.imageView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var selectView: UIView!
    @IBOutlet weak var selectImageView: UIImageView!
    
    override var isSelected: Bool {
        didSet{
            selectView.isHidden = !isSelected
            selectImageView.isHidden = !isSelected
        }
    }

    
    static let reuseIdentifier = "UnPopularMovieCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
   
}
