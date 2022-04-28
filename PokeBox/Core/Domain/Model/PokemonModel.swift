//
//  PokemonModel.swift
//  PokeBox
//
//  Created by Enygma System on 27/04/22.
//

import Foundation

struct PokemonModel: Equatable, Identifiable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let stats: [PokemonStatModel]
    let types: [String]
    let abilities: [PokemonAbilityModel]
}

struct PokemonStatModel: Equatable {
    let name: String
    let value: Int
}

struct PokemonAbilityModel: Equatable {
    let name: String
    let effect: [String]
}
