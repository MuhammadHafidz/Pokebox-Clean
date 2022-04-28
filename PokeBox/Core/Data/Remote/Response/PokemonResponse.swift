//
//  PokemonResponse.swift
//  PokeBox
//
//  Created by Enygma System on 27/04/22.
//

import Foundation

struct PokemonDataResponse: Decodable {
    let data: PokemonResponses
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}

struct PokemonResponses: Decodable {
    let pokemon: [PokemonResponse]
    
    enum CodingKeys: String, CodingKey {
        case pokemon
    }
}

struct PokemonResponse: Decodable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let stats: [PokemonStatResponse]
    let types: [PokemonTypeResponse]
    let abilities: [PokemonAbilityResponse]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case height
        case weight
        case stats
        case types
        case abilities
    }
}

struct PokemonStatResponse: Decodable {
    let value: Int
    let stat: PokemonStatNameResponse
    
    enum CodingKeys: String, CodingKey {
        case value
        case stat
    }
}

struct PokemonStatNameResponse: Decodable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}

struct PokemonTypeResponse: Decodable {
    let type: PokemonTypeNameResponse
    
    enum CodingKeys: String, CodingKey {
        case type
    }
}

struct PokemonTypeNameResponse: Decodable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}

struct PokemonAbilityResponse: Decodable {
    let ability: PokemonAbilityNameResponse
    
    enum CodingKeys: String, CodingKey {
        case ability
    }
}

struct PokemonAbilityNameResponse: Decodable {
    let name: String
    let effects: [PokemonAbilityEffectResponse]
    
    enum CodingKeys: String, CodingKey {
        case name
        case effects
    }
}

struct PokemonAbilityEffectResponse: Decodable {
    let effect: String
    
    enum CodingKeys: String, CodingKey {
        case effect
    }
}
