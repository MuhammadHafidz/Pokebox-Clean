///Users/enygmasystem/Documents/Haff/PokeBox/.swiftlint.yml
//  Injection.swift
//  PokeBox
//
//  Created by Enygma System on 27/04/22.
//

import Foundation
import RealmSwift

final class Injection: NSObject {
    private func provideRepository() -> PokemonRepositoryProtocol {
        let realm = try? Realm()
        
        let local: LocaleDataSource = LocaleDataSource.shared(realm)
        let remote: PokemonRemoteDataSource = PokemonRemoteDataSource.shared
        
        return PokemonRepository.sharedInstance(local, remote)
    }
    
    func provideHome() -> HomeUseCase {
        let repository = provideRepository()
        return HomeInteractor(repository: repository)
    }
    
    func provideDetail(data: PokemonModel) -> DetailUseCase {
        let repository = provideRepository()
        return DetailInteractor(repository: repository, data: data)
    }
    
    func provideFavorite() -> FavoriteUseCase {
        let repository = provideRepository()
        return FavoriteInteractor(repository: repository)
    }
}
