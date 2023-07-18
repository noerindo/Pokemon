//
//  UpdatePokemonViewController.swift
//  Pokemon
//
//  Created by Indah Nurindo on 17/07/2566 BE.
//

import UIKit

class UpdatePokemonViewController: UIViewController {

    @IBOutlet weak var editWeightPokemon: UITextField!
    @IBOutlet weak var editHeighPokemon: UITextField!
    @IBOutlet weak var editNamePokemon: UITextField!
    
    var pokemonNameEdit: String = ""
    var id: Int32 = 0
    var pokemonHeigtEdit: String = ""
    var pokemonWeigtEdit: String = ""
    var pokemonPhotoedit: String = ""
    var poke: FavoritePokemonModel?
    
    private lazy var favoriteProvider: PokemonProvider = { return PokemonProvider()}()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editNamePokemon.text = pokemonNameEdit
        editHeighPokemon.text = pokemonHeigtEdit
        editWeightPokemon.text = pokemonWeigtEdit
        
        favoriteProvider.getAllFavoritePokemon(completion: { pokemon in
            print("fetchPokeFavList=",pokemon)
        })
//        guard let pokeData = poke else { return }
//        DispatchQueue.main.async {
//            self.configure(editNamePokemon: pokeData.pokemonName!, editHeightPokemon: pokeData.pokemonHeight!, editWeightPokemon: pokeData.pokemonWeight!)
//        }
        // Do any additional setup after loading the view.
    }
    
//    private func configure(
//        editNamePokemon: String,
//        editHeightPokemon: String,
//        editWeightPokemon: String
//    ) {
//        self.editNamePokemon.text = editNamePokemon
//        self.editHeighPokemon.text = editHeightPokemon
//        self.editWeightPokemon.text = editWeightPokemon
//    }
    

    @IBAction func updateSaveBtn(_ sender: UIButton) {
//        guard let namePokemon =  else { return }
//        guard let weightPokemon = editWeightPokemon else { return }
//        guard let heighPokemon = editHeighPokemon else { return }
//
//        favoriteProvider.updatePokemon(id, pokemonHeigtEdit, pokemonNameEdit, pokemonWeigtEdit) {
//            print("testt")
//        }
        print("UpdateSave=",pokemonNameEdit,pokemonHeigtEdit,pokemonWeigtEdit)
        
        favoriteProvider.updatePokemon(editHeighPokemon.text ?? pokemonHeigtEdit, editNamePokemon.text ?? pokemonNameEdit, editWeightPokemon.text ?? pokemonWeigtEdit, pokemonPhotoedit, completion: {
        })
        
        favoriteProvider.getAllFavoritePokemon(completion: {pokemon in
            DispatchQueue.main.async { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
        })
//        favoriteProvider.updatePokemonNew(editNamePokemon.text ?? pokemonNameEdit, editHeighPokemon.text ?? pokemonHeigtEdit, editWeightPokemon.text ?? pokemonWeigtEdit)
    }
}
