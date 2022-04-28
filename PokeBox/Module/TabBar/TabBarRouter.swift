//
//  TabBarRouter.swift
//  PokeBox
//
//  Created by Enygma System on 27/04/22.
//

import UIKit

class TabBarRouter {
    private let storyBoard: UIStoryboard
    
    init() {
        self.storyBoard = UIStoryboard(name: "Main", bundle: nil)
    }
    
    func makeHomeView() -> UIViewController {
        guard let homeVC = storyBoard.instantiateViewController(withIdentifier: "homeViewController")
                as? HomeViewController else {
            return UIViewController()
        }
        homeVC.presenter = HomePresenter(homeUseCase: Injection.init().provideHome())
        return homeVC
    }
    
    func makeHomeNavigation() -> UINavigationController {
        guard let homeNC = storyBoard.instantiateViewController(withIdentifier: "homeNavigationController")
                as? HomeNavigationController else {
            return UINavigationController()
        }
        homeNC.viewControllers = [makeHomeView()]
        return homeNC
    }
    
    func makeFavoriteView() -> UIViewController {
        guard let favoriteVC = storyBoard.instantiateViewController(withIdentifier: "favoriteViewController")
                as? FavoriteViewController else {
            return UIViewController()
        }
        favoriteVC.presenter = FavoritePresenter(useCase: Injection.init().provideFavorite())
        return favoriteVC
    }
    
    func makeFavoriteNavigation() -> UINavigationController {
        guard let favoriteNC = storyBoard.instantiateViewController(withIdentifier: "favoriteNavigationController")
                as? FavoriteNavigationController else {
            return UINavigationController()
        }
        favoriteNC.viewControllers = [makeFavoriteView()]
        return favoriteNC
    }
    
    func makeTabBar() -> TabBarViewController {
        guard let tabBarVC = storyBoard.instantiateViewController(withIdentifier: "mainTabBar")
                as? TabBarViewController else {
            return TabBarViewController()
        }
        tabBarVC.viewControllers = [makeHomeNavigation(), makeFavoriteNavigation()]
        return tabBarVC
    }
    
}
