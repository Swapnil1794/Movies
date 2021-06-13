//
//  ViewController.swift
//  Movie Flix App!
//
//  Created by Swapnil Gavali on 11/06/21.
//

import UIKit

class MoviesViewController: UIViewController {
    
    var coordinator: Coordinator?
    
    private var moviesViewModel:MoviesViewModel!
    
    //MARK: Outlets and Views
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout { sectionNumber, env in
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: NSCollectionLayoutDimension.fractionalWidth(1), heightDimension: NSCollectionLayoutDimension.fractionalHeight(1)))
        item.contentInsets.bottom = 16
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize.init(widthDimension: NSCollectionLayoutDimension.fractionalWidth(1), heightDimension: NSCollectionLayoutDimension.absolute(250)), subitems: [item])
        let section =  NSCollectionLayoutSection(group: group)
        section.contentInsets.leading = 16
        section.contentInsets.trailing = 16
        section.contentInsets.top = 16
        
        let header = NSCollectionLayoutBoundarySupplementaryItem.init(layoutSize: NSCollectionLayoutSize.init(widthDimension: NSCollectionLayoutDimension.fractionalWidth(1), heightDimension: .absolute(50)), elementKind: SearchView.searchViewReuseIdentifier, alignment: .top)
        header.pinToVisibleBounds = true
        section.boundarySupplementaryItems = [ header ]
      
        return section
    })
    
    lazy var deleteBarButton:UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didDeleteBtnTapped(_:)))
    }()
    
    lazy var selectBarButton:UIBarButtonItem = {
        return UIBarButtonItem(title: "Select", style: .plain, target: self, action: #selector(didSelectBtnTapped(_:)))
    }()
    
    
    //MARK: controller methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(collectionView)
        self.title = moviesViewModel.title
        collectionView.backgroundColor = Colors.backGroundColor
        collectionView.frame = self.view.bounds
        registerCell()
        setUpBarButtonItem()
        
        moviesViewModel.didDataChanged.bind { [unowned self] value in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }
        bindMode()
        
    }
    
    //MARK: Custom methods
    
    func bindMode() {
        moviesViewModel.mode.bind { [unowned self] mode in
            switch mode {
            case .view:
                for i in 0 ..< moviesViewModel.movieViewModels.count {
                    if moviesViewModel.movieViewModels[i].isSelected {
                        moviesViewModel.movieViewModels[i].isSelected = false
                        collectionView.deselectItem(at: IndexPath(item: i, section: 0), animated: true)
                    }
                }
                selectBarButton.title = "Select"
                navigationItem.leftBarButtonItem = nil
                collectionView.allowsMultipleSelection = false
            case .selected:
                selectBarButton.title = "Cancel"
                navigationItem.leftBarButtonItem = deleteBarButton
                collectionView.allowsMultipleSelection = true
            }
            
        }
    }
    
    @objc func didDeleteBtnTapped(_ sender:UIBarButtonItem) {
        collectionView.deleteItems(at: moviesViewModel.getSelectedIndexPaths())
    }
    @objc func didSelectBtnTapped(_ sender:UIBarButtonItem) {
        moviesViewModel.mode.value = moviesViewModel.mode.value == .view ? .selected : .view
    }
    private func setUpBarButtonItem()  {
        navigationItem.rightBarButtonItem = selectBarButton
    }
    
    private func registerCell() {
        collectionView.register(UINib(nibName: "PopularMovieCell", bundle: nil), forCellWithReuseIdentifier: PopularMovieCell.reuseIdentifier)
        collectionView.register(UINib(nibName: "UnPopularMovieCell", bundle: nil), forCellWithReuseIdentifier: UnPopularMovieCell.reuseIdentifier)
        
        collectionView.register(UINib(nibName: "SearchView", bundle: nil), forSupplementaryViewOfKind: SearchView.searchViewReuseIdentifier, withReuseIdentifier: SearchView.searchViewReuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    static func instantiate(viewModel:MoviesViewModel) -> MoviesViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateViewController(identifier: "MoviesViewController") as! MoviesViewController
        vc.moviesViewModel = viewModel
        return vc 
    }
    
    
    
}

//MARK: UICollectionView methods
extension MoviesViewController : UICollectionViewDataSource , UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesViewModel.movieViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movieViewModel = moviesViewModel.movieViewModels[indexPath.row]
        if movieViewModel.voteCount > 7  {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularMovieCell.reuseIdentifier, for: indexPath) as! PopularMovieCell
            cell.movieViewModel = movieViewModel
            return cell
        }else{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UnPopularMovieCell.reuseIdentifier, for: indexPath) as! UnPopularMovieCell
            cell.movieViewModel = movieViewModel
            return cell
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch moviesViewModel.mode.value {
        case .view:
            collectionView.deselectItem(at: indexPath, animated: true)
            let coordinator = coordinator as? MainCoordinator
            coordinator?.launchDetailsController(viewModel: moviesViewModel.movieViewModels[indexPath.row])
            break
        case .selected:
            moviesViewModel.movieViewModels[indexPath.row].isSelected = true
            break
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        switch moviesViewModel.mode.value {
        case .view:
            break
        case .selected:
            moviesViewModel.movieViewModels[indexPath.row].isSelected = false
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SearchView.searchViewReuseIdentifier, for: indexPath) as? SearchView
        header?.searchBar.delegate = self
        header?.backgroundColor = Colors.backGroundColor
        return header!
    }
    
}

extension MoviesViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        moviesViewModel.getFilteredMovies(string: searchBar.text!)
    }
}


extension MoviesViewController : Coordinating {
    
}
