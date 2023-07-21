//
//  CollectionViewCell.swift
//  Pokemon
//
//  Created by Indah Nurindo on 12/07/2566 BE.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {


    @IBOutlet weak var photoPokemon: UIImageView!
    @IBOutlet weak var namePokemon: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with pokemonFav: FavoritePokemonModel) {
        photoPokemon.image = pokemonFav.pokemonPhoto.imageFromBase64
        namePokemon.text = pokemonFav.pokemonName
    }
    
    func configure(with pokemonModel: Pokemonn) {
        let idPhoto = NetworkService.sharedApi.getIdFromUrl(url: pokemonModel.url) { resultId in
            var idPoke = resultId!
            let imgUrl = URL(string:"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(idPoke).png")
            self.photoPokemon.sd_setImage(with: imgUrl)
        }
        namePokemon.text = pokemonModel.name
    }
}

