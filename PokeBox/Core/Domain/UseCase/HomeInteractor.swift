//
//  HomeInteractor.swift
//  PokeBox
//
//  Created by Enygma System on 27/04/22.
//

import Foundation
import RxSwift

protocol HomeUseCase {
    func getPokemons(offset: Int) -> Observable<[PokemonModel]>
}

class HomeInteractor: HomeUseCase {
    
    private let repository: PokemonRepositoryProtocol
    
    required init( repository: PokemonRepositoryProtocol) {
        self.repository = repository
    }
    
    func getPokemons(offset: Int) -> Observable<[PokemonModel]> {
        return repository.getPokemons(offset: offset)
    }
    
}
