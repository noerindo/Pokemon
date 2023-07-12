//
//  PokemonModel.swift
//  Pokemon
//
//  Created by Indah Nurindo on 12/07/2566 BE.
//

import Foundation

struct Pokemon: Codable {
    var name: String
    var url: String
    
    //untuk menyamakan nama variabel di json kalau yang diatas struk pokemon index sama maka tidak perlu di init seperti dibawah ini.
//    enum CodingKeys: String, CodingKey {
//        case name
//        case url = "url"
//    }
    
}

struct PokemonIndex: Codable {
    let results: [Pokemon]
}
