//
//  PokemonMapper.swift
//  PokeBox
//
//  Created by Enygma System on 27/04/22.
//

import Foundation

final class PokemonMapper {
    static func responsesToModel(
        input pokemonResponses: [PokemonResponse]
    ) -> [PokemonModel] {
        return pokemonResponses.map { data in
            return PokemonModel(
                id: data.id,
                name: data.name.capitalized,
                height: data.height,
                weight: data.weight,
                stats: data.stats.map { stat in
                    return PokemonStatModel(name: stat.stat.name.capitalized, value: stat.value)
                },
                types: data.types.map { type in
                    return type.type.name.capitalized
                },
                abilities: data.abilities.map { ability in
                    return PokemonAbilityModel(
                        name: ability.ability.name.capitalized,
                        effect: ability.ability.effects.map { effect in
                        return effect.effect
                    })
                })
        }
    }
    
    static func modelToEntity(
        input pokemonModel: PokemonModel
    ) -> PokemonEntity {
        let pokemonEntity = PokemonEntity()
        pokemonEntity.id = pokemonModel.id
        pokemonEntity.name = pokemonModel.name
        pokemonEntity.height = pokemonModel.height
        pokemonEntity.weight = pokemonModel.weight
        
        for stat in pokemonModel.stats {
            let pokemonStat = PokemonStatEntity()
            pokemonStat.name = stat.name
            pokemonStat.value = stat.value
            pokemonEntity.stats.append(pokemonStat)
        }
        
        for type in pokemonModel.types {
            pokemonEntity.types.append(type)
        }
        
        for ability in pokemonModel.abilities {
            let pokemonAbility = PokemonAbilityEntity()
            pokemonAbility.name = ability.name
            
            for effect in ability.effect {
                pokemonAbility.effect.append(effect)
            }
            pokemonEntity.abilities.append(pokemonAbility)
        }
        return pokemonEntity
    }
    
    static func entityToModel(
        input pokemonEntity: PokemonEntity?
    ) -> PokemonModel? {
        if let data = pokemonEntity {
            return PokemonModel(
                id: data.id,
                name: data.name,
                height: data.height,
                weight: data.weight,
                stats: data.stats.map { stat in
                    return PokemonStatModel(name: stat.name, value: stat.value)
                },
                types: data.types.map { type in
                    return type
                },
                abilities: data.abilities.map { ability in
                    return PokemonAbilityModel(
                        name: ability.name,
                        effect: ability.effect.map { effect in
                        return effect
                    })
                })
        } else {
            return nil
        }
    }
    
    static func entitiesToModel(
        input pokemonEntity: [PokemonEntity]
    ) -> [PokemonModel] {
        return pokemonEntity.map { data in
            return PokemonModel(
                id: data.id,
                name: data.name,
                height: data.height,
                weight: data.weight,
                stats: data.stats.map { stat in
                    return PokemonStatModel(name: stat.name, value: stat.value)
                },
                types: data.types.map { type in
                    return type
                },
                abilities: data.abilities.map { ability in
                    return PokemonAbilityModel(
                        name: ability.name,
                        effect: ability.effect.map { effect in
                        return effect
                    })
                })
        }
    }

}
