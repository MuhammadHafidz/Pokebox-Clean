//
//  DetailInteractor.swift
//  PokeBox
//
//  Created by Enygma System on 27/04/22.
//

import Foundation
import RxSwift

protocol DetailUseCase {
    func getFavoritePokemon(id: Int) -> Observable<PokemonModel?>
    func addFavorite(pokemon: PokemonModel) -> Observable<Bool>
    func deleteFavorite(id: Int) -> Observable<Bool>
    func getPokemonData() -> PokemonModel
}

class DetailInteractor: DetailUseCase {
    
    private let repository: PokemonRepositoryProtocol
    private let pokemonData: PokemonModel
    
    required init( repository: PokemonRepositoryProtocol, data: PokemonModel) {
        self.repository = repository
        self.pokemonData = data
    }
    
    func getFavoritePokemon(id: Int) -> Observable<PokemonModel?> {
        return repository.getFavorite(id: id)
    }
    
    func addFavorite(pokemon: PokemonModel) -> Observable<Bool> {
        return repository.addFavorite(from: pokemon)
    }
    
    func deleteFavorite(id: Int) -> Observable<Bool> {
        return repository.deleteFavorite(id: id)
    }
    
    func getPokemonData() -> PokemonModel {
        return pokemonData
    }
}
