//
//  LocaleDataSource.swift
//  PokeBox
//
//  Created by Enygma System on 27/04/22.
//

import Foundation
import RealmSwift
import RxSwift

protocol LocaleDataSourceProtocol: AnyObject {
    func getPokemons() -> Observable<[PokemonEntity]>
    func getPokemon(id: Int) -> Observable<PokemonEntity?>
    func addPokemon(from pokemon: PokemonEntity) -> Observable<Bool>
    func deletePokemon(id: Int) -> Observable<Bool>
}

final class LocaleDataSource: NSObject {
    private let realm: Realm?
    private init(realm: Realm?) {
        self.realm = realm
    }
    static let shared: (Realm?) -> LocaleDataSource = { realmDatabase in
        return LocaleDataSource(realm: realmDatabase)
    }
}

extension LocaleDataSource: LocaleDataSourceProtocol {
    func getPokemons() -> Observable<[PokemonEntity]> {
        return Observable<[PokemonEntity]>.create { observer in
            if let realm = self.realm {
                let pokemon: Results<PokemonEntity> = {
                    realm.objects(PokemonEntity.self)
                }()
                observer.onNext(pokemon.toArray(ofType: PokemonEntity.self))
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    func getPokemon(id: Int) -> Observable<PokemonEntity?> {
        return Observable<PokemonEntity?>.create { observer in
            if let realm = self.realm {
                if let object = realm.objects(PokemonEntity.self).filter("id = \(id)").first {
                    observer.onNext(object)
                    observer.onCompleted()
                } else {
                    observer.onNext(nil)
                    observer.onCompleted()
                }
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    func addPokemon(from pokemon: PokemonEntity) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self.realm {
                do {
                    try realm.write {
                        realm.add(pokemon, update: .all)
                        observer.onNext(true)
                        observer.onCompleted()
                    }
                } catch {
                    observer.onError(DatabaseError.requestFailed)
                }
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    func deletePokemon(id: Int) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self.realm {
                if let object = realm.objects(PokemonEntity.self).filter("id = \(id)").first {
                    do {
                        try realm.write {
                            realm.delete(object)
                        }
                        observer.onNext(true)
                        observer.onCompleted()
                    } catch {
                        observer.onError(DatabaseError.requestFailed)
                    }
                }
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
}
