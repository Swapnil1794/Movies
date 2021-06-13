//
//  Coordinator.swift
//  Movie Flix App!
//
//  Created by Swapnil Gavali on 12/06/21.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController:UINavigationController? { get set}
    func start()
}
protocol Coordinating {
    var coordinator:Coordinator? { get set }
}
class MainCoordinator : NSObject , Coordinator , UINavigationControllerDelegate {
    
    var navigationController: UINavigationController?
    
    private let window : UIWindow
    
    init(window:UIWindow) {
        self.window = window
    }
    
    func start()  {
        var moviesViewController:UIViewController & Coordinating = MoviesViewController.instantiate(viewModel: MoviesViewModel())
        navigationController = UINavigationController(rootViewController: moviesViewController)
        navigationController?.delegate = self
        moviesViewController.coordinator = self 
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
    }
    
    func launchDetailsController(viewModel:MovieViewModel) {
        let vc : MovieDetailsViewController & Coordinating = MovieDetailsViewController.instantiate()
        vc.movieViewModel = viewModel
        vc.coordinator = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
    }
    
}
