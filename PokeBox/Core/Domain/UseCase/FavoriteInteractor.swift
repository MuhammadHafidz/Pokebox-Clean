//
//  FavoriteInteractor.swift
//  PokeBox
//
//  Created by Enygma System on 27/04/22.
//

import Foundation
import RxSwift

protocol FavoriteUseCase {
    func getFavoriteGames() -> Observable<[PokemonModel]>
}

class FavoriteInteractor: FavoriteUseCase {
    private let repository: PokemonRepositoryProtocol
    
    required init( repository: PokemonRepositoryProtocol) {
        self.repository = repository
    }
    
    func getFavoriteGames() -> Observable<[PokemonModel]> {
        return self.repository.getFavorites()
    }
}
