//
//  PokemonRepository.swift
//  PokeBox
//
//  Created by Enygma System on 27/04/22.
//

import Foundation
import RxSwift
import RealmSwift

protocol PokemonRepositoryProtocol {
    func getPokemons(offset: Int) -> Observable<[PokemonModel]>
    func getFavorites() -> Observable<[PokemonModel]>
    func getFavorite(id: Int) -> Observable<PokemonModel?>
    func addFavorite(from pokemon: PokemonModel) -> Observable<Bool>
    func deleteFavorite(id: Int) -> Observable<Bool>
}

final class PokemonRepository: NSObject {
    typealias PokemonInstance = (LocaleDataSource, PokemonRemoteDataSource) -> PokemonRepository
    fileprivate let remote: PokemonRemoteDataSource
    fileprivate let locale: LocaleDataSource
    private init(locale: LocaleDataSource, remote: PokemonRemoteDataSource) {
        self.remote = remote
        self.locale = locale
    }
    static let sharedInstance: PokemonInstance = { localeRepo, remoteRepo in
        return PokemonRepository(locale: localeRepo, remote: remoteRepo)
    }
}

extension PokemonRepository: PokemonRepositoryProtocol {
    func getPokemons(offset: Int) -> Observable<[PokemonModel]> {
        return self.remote.getPokemons(offset)
            .map { PokemonMapper.responsesToModel(input: $0)}
    }
    
    func getFavorites() -> Observable<[PokemonModel]> {
        return self.locale.getPokemons()
            .map { PokemonMapper.entitiesToModel(input: $0)}
    }
    
    func getFavorite(id: Int) -> Observable<PokemonModel?> {
        return self.locale.getPokemon(id: id)
            .map { PokemonMapper.entityToModel(input: $0)}
    }
    
    func addFavorite(from pokemon: PokemonModel) -> Observable<Bool> {
        return self.locale.addPokemon(from: PokemonMapper.modelToEntity(input: pokemon))
    }
    
    func deleteFavorite(id: Int) -> Observable<Bool> {
        return self.locale.deletePokemon(id: id)
    }
    
}
