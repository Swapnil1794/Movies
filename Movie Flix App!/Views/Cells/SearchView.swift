//
//  SearchView.swift
//  Movie Flix App!
//
//  Created by Swapnil Gavali on 11/06/21.
//

import UIKit

class SearchView: UICollectionReusableView {

    @IBOutlet weak var searchBar: UISearchBar! {
        didSet{
            searchBar.backgroundImage = UIImage()
        }
    }
    
    static let searchViewReuseIdentifier = "SearchView"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
