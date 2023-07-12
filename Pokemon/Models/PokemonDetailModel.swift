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
    var sprites: Sprites?
    
}

struct Sprites: Codable {
    var back_default: URL
    
    enum CodingKeys: CodingKey {
        case back_default
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
       let path = try container.decode(URL.self, forKey: .back_default)
        self.back_default = URL(string: "\(path)")!
    }
}

