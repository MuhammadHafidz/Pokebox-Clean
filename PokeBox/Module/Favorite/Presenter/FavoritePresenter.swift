//
//  FavoritePresenter.swift
//  PokeBox
//
//  Created by Enygma System on 27/04/22.
//

import Foundation
import RxSwift
import UIKit

protocol FavoritePresenterToViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func showError(message: String)
    func updateTableView()
}

class FavoritePresenter {
    private let disposeBag = DisposeBag()
    private let useCase: FavoriteUseCase
    var pokemonData: [PokemonModel] = []
    var view: FavoritePresenterToViewProtocol?
    private var router = HomeRouter()
    
    init ( useCase: FavoriteUseCase) {
        self.useCase = useCase
    }
    
    func getData() {
        print("Load Data")
        view?.showLoading()
        useCase.getFavoriteGames()
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.pokemonData = result
                self.view?.updateTableView()
            } onError: { error in
                self.view?.showError(message: error.localizedDescription)
            } onCompleted: {
                self.view?.hideLoading()
            }
            .disposed(by: disposeBag)
    }
    
    func toDetail(index: Int, navigationControll: UINavigationController?) {
        router.toDetail(pokemon: pokemonData[index], navigationController: navigationControll)
    }
}
