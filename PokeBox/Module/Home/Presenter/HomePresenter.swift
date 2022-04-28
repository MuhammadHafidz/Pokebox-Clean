//
//  HomePresenter.swift
//  PokeBox
//
//  Created by Enygma System on 27/04/22.
//

import Foundation
import RxSwift
import UIKit

protocol HomePresenterToViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func showError(message: String)
    func updateTableView()
}

class HomePresenter {
    private let disposeBag = DisposeBag()
    private let homeUseCase: HomeUseCase
    var pokemonData: [PokemonModel] = []
    var view: HomePresenterToViewProtocol?
    private var router = HomeRouter()
    
    init ( homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }
    
    func getData() {
        view?.showLoading()
        homeUseCase.getPokemons(offset: pokemonData.count)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.pokemonData += result
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
