//
//  PokemonEntity.swift
//  PokeBox
//
//  Created by Enygma System on 27/04/22.
//

import Foundation
import RealmSwift

class PokemonEntity: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String = ""
    @Persisted var height: Int = 0
    @Persisted var weight: Int = 0
    @Persisted var stats: List<PokemonStatEntity> = List<PokemonStatEntity>()
    @Persisted var types: List<String> = List<String>()
    @Persisted var abilities: List<PokemonAbilityEntity> = List<PokemonAbilityEntity>()
}

class PokemonStatEntity: Object {
    @Persisted var name: String = ""
    @Persisted var value: Int = 0
}

class PokemonAbilityEntity: Object {
    @Persisted var name: String = ""
    @Persisted var effect: List<String> = List<String>()
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for index in 0 ..< count {
            if let result = self[index] as? T {
                array.append(result)
            }
        }
        return array
    }
}
