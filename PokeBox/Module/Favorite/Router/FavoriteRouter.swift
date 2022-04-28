//
//  FavoriteRouter.swift
//  PokeBox
//
//  Created by Enygma System on 27/04/22.
//

import Foundation
import UIKit

class FavoriteRouter {
    
    func toDetail(pokemon: PokemonModel, navigationController: UINavigationController?) {
        let detailVC = DetailViewController(nibName: "DetailViewController", bundle: nil)
        detailVC.presenter = DetailPresenter(detailUseCase: Injection.init().provideDetail(data: pokemon))
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
