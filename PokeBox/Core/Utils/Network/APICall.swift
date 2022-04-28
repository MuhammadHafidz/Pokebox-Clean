//
//  APICall.swift
//  PokeBox
//
//  Created by Enygma System on 27/04/22.
//

import Foundation

struct API {
    static let url = "https://beta.pokeapi.co/"
    static let limitLoad = 10
}

struct PokemonImage {
    static func url(id: Int) -> String {
        return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/\(id).svg"
    }
}

protocol EndPoint {
    var url: String { get }
}

enum EndPoints {
    enum Gets: EndPoint {
        case graphQl
        
        public var url: String {
            switch self {
            case .graphQl: return "\(API.url)graphql/v1beta"
            }
        }
    }
}

protocol GraphQlQuery {
    var query: String { get }
}

enum GqlQuerys {
    enum Queries: GraphQlQuery {
        case pokemons(offset: Int)
        
        public var query: String {
            switch self {
            case .pokemons(let offset):
                return """
query{
  pokemon: pokemon_v2_pokemon(limit: 10, offset: \(offset)) {
    id
    name
    height
    weight
    stats: pokemon_v2_pokemonstats {
      value: base_stat
      stat: pokemon_v2_stat {
        name
      }
    }
    types: pokemon_v2_pokemontypes {
      type: pokemon_v2_type {
        name
      }
    }
    abilities: pokemon_v2_pokemonabilities {
      ability: pokemon_v2_ability {
        name
        effects: pokemon_v2_abilityeffecttexts(where: {language_id: {_eq: 9}}, limit: 1) {
          effect
        }
      }
    }
  }
}
"""
            }
        }
    }
}
