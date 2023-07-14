//
//  PokemonModel.swift
//  Pokemon
//
//  Created by Indah Nurindo on 12/07/2566 BE.
//

import Foundation

struct Pokemonn: Codable {
    var name: String
    var url: String
    
    //untuk menyamakan nama variabel di json kalau yang diatas struk pokemon index sama maka tidak perlu di init seperti dibawah ini.
//    enum CodingKeys: String, CodingKey {
//        case name
//        case url = "url"
//    }
    
}

struct PokemonIndex: Codable {
    let results: [Pokemonn]
}

struct FavoritePokemonModel{
    var id: Int32?
    var pokemonCount1: String?
    var pokemonCount2: String?
    var pokemonHeight: String?
    var pokemonNamaType1: String?
    var pokemonNamaType2: String?
    var pokemonName: String?
    var pokemonPhoto: String
    var pokemonWeight: String?
    
}

