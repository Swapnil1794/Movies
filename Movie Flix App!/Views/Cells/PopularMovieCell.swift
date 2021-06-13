//
//  MovieCell.swift
//  Movie Flix App!
//
//  Created by Swapnil Gavali on 11/06/21.
//

import UIKit

class PopularMovieCell: UICollectionViewCell {

    
    var movieViewModel:MovieViewModel! {
        didSet{
            imageView.loadImageUsingUrlString(urlString:movieViewModel.backdropPath)
        }
    }
    
    @IBOutlet weak var imageView: CustomImageView! {
        didSet{
            self.imageView.layer.cornerRadius = 10
            self.imageView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var selectView: UIView!
    @IBOutlet weak var selectImageView: UIImageView!
    

    override var isSelected: Bool {
        didSet{
            selectView.isHidden = !isSelected
            selectImageView.isHidden = !isSelected
        }
    }
    
    static let reuseIdentifier = "PopularMovieCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    

}
