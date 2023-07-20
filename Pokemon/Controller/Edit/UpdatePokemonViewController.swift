//
//  UpdatePokemonViewController.swift
//  Pokemon
//
//  Created by Indah Nurindo on 17/07/2566 BE.
//

import UIKit

protocol UpdatePokemonViewControllerDelegate: AnyObject {
    
    func setDetailModel(newModel: FavoritePokemonModel)
}

class UpdatePokemonViewController: UIViewController {

    var delegate: UpdatePokemonViewControllerDelegate?
    var pokeUpdate = FavoritePokemonModel()
    var pokeModelView = PokemonFavoriteModelView()
    @IBOutlet weak var editWeightPokemon: UITextField!
    @IBOutlet weak var editHeighPokemon: UITextField!
    @IBOutlet weak var editNamePokemon: UITextField!
    
    var pokemonNameEdit: String = ""
    var id: Int32 = 0
    var pokemonHeigtEdit: String = ""
    var pokemonWeigtEdit: String = ""
    var pokemonPhotoedit: String = ""
    
    private lazy var favoriteProvider: PokemonProvider = { return PokemonProvider()}()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editNamePokemon.text = pokeUpdate.pokemonName
        editHeighPokemon.text = pokeUpdate.pokemonHeight
        editWeightPokemon.text = pokeUpdate.pokemonWeight
        pokemonPhotoedit = pokeUpdate.pokemonPhoto
        
        favoriteProvider.getAllFavoritePokemon(completion: { pokemon in
        })
    }

    @IBAction func updateSaveBtn(_ sender: UIButton) {
        pokeModelView.editPoke(self) { [weak self] newModel in
            
            self?.delegate?.setDetailModel(newModel: newModel)
            
            // Dengan escaping
            self?.favoriteProvider.getAllFavoritePokemon { pokemon in
                DispatchQueue.main.async { [weak self] in
                    guard let pokeUpdate = self?.pokeUpdate else { return }
                    print("get all favorite di update save button : \(pokeUpdate.pokemonName)")
                    self?.navigationController?.popViewController(animated: true)

                }
            }
            
            // Tanpa escaping
//            self?.favoriteProvider.getAllFavoritePokemon(completion: {pokemon in
//                DispatchQueue.main.async { [weak self] in
//                    guard let pokeUpdate = self?.pokeUpdate else { return }
//                    print("get all favorite di update save button : \(pokeUpdate.pokemonName)")
//                    self?.delegate?.setDetailModel(newModel: pokeUpdate)
//                    self?.navigationController?.popViewController(animated: true)
//                }
//            })
        }
        
//        favoriteProvider.updatePokemonNew(editNamePokemon.text ?? pokemonNameEdit, editHeighPokemon.text ?? pokemonHeigtEdit, editWeightPokemon.text ?? pokemonWeigtEdit)
    }
}
