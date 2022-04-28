//
//  DetailPresenter.swift
//  PokeBox
//
//  Created by Enygma System on 27/04/22.
//

import Foundation
import RxSwift

protocol DetailPresenterToViewProtocol {
    func setData()
    func setFavorite()
    func showLoading()
    func hideLoading()
    func showError(message: String)
}

class DetailPresenter {
    private let disposeBag = DisposeBag()
    private let detailUseCase: DetailUseCase
    var pokemon: PokemonModel
    var isFavorite: Bool = false
    var view: DetailPresenterToViewProtocol?
    
    init (detailUseCase: DetailUseCase) {
        self.detailUseCase = detailUseCase
        self.pokemon = self.detailUseCase.getPokemonData()
        getFavorite()
    }
    
    func getFavorite() {
        view?.showLoading()
        detailUseCase.getFavoritePokemon(id: pokemon.id)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                if result != nil {
                    self.isFavorite = true
                } else {
                    self.isFavorite = false
                }
                
                self.view?.setFavorite()
            } onError: { error in
                self.view?.showError(message: error.localizedDescription)
            } onCompleted: {
                self.view?.hideLoading()
            }
            .disposed(by: disposeBag)
    }
    
    func addFavorite() {
        view?.showLoading()
        detailUseCase.addFavorite(pokemon: pokemon)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.isFavorite = result
                self.view?.setFavorite()
            } onError: { error in
                self.view?.showError(message: error.localizedDescription)
            } onCompleted: {
                self.view?.hideLoading()
            }
            .disposed(by: disposeBag)
    }
    
    func deleteFavorite() {
        view?.showLoading()
        detailUseCase.deleteFavorite(id: pokemon.id)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.isFavorite = !result
                self.view?.setFavorite()
            } onError: { error in
                self.view?.showError(message: error.localizedDescription)
            } onCompleted: {
                self.view?.hideLoading()
            }
            .disposed(by: disposeBag)
    }
    
}
