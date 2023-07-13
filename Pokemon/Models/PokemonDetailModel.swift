//
//  PokemonDetailModel.swift
//  Pokemon
//
//  Created by Indah Nurindo on 12/07/2566 BE.
//

import Foundation

struct PokemonDetail: Codable {
    var id: Int
    var height: Int
    var weight: Int
    var name: String
    var types: [Types]
    var sprites: Sprites?
    
}

struct Sprites: Codable {
    var back_default: URL
//    var front_shiny: URL
}

struct Types: Codable {
    var slot: Int
    var type: Type2?
}

struct Type2: Codable {
    var name2: String
    
    enum CodingKeys: String,CodingKey {
        case name2 = "name"
    }
}

