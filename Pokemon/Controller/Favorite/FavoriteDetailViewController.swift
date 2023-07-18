//
//  FavoriteDetailViewController.swift
//  Pokemon
//
//  Created by Indah Nurindo on 14/07/2566 BE.
//

import UIKit

class FavoriteDetailViewController: UIViewController {
    
    @IBOutlet weak var photoPoke: UIImageView!
    
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var ViewCard2Bg: UIView! {
        didSet {
            ViewCard2Bg.layer.cornerRadius = 30
            ViewCard2Bg.backgroundColor = UIColor.yellow
        }
    }
    
    @IBOutlet weak var viewCardPoke: UIView! {
        didSet {
            viewCardPoke.layer.cornerRadius = 30
            viewCardPoke.backgroundColor = UIColor.gray
        }
    }
    
    @IBOutlet weak var favPokeBtn: UIButton! {
        didSet{
            favPokeBtn.setImage(UIImage(systemName: "suit.heart.fill")!.withTintColor(.red,renderingMode: .alwaysOriginal), for: .normal)
        }
    }
    @IBOutlet weak var weightPoke: UILabel!
    @IBOutlet weak var heightPoke: UILabel!
    @IBOutlet weak var countTypePoke2: UILabel!
    @IBOutlet weak var countTypePoke1: UILabel!
    @IBOutlet weak var nameTypePoke2: UILabel!
    @IBOutlet weak var nameTypePoke1: UILabel!
    @IBOutlet weak var namePoke: UILabel!
    var poke: FavoritePokemonModel?
    
    private lazy var favoriteProvider: PokemonProvider = { return PokemonProvider() }()

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let pokeData = poke else { return }
        DispatchQueue.main.async {
            self .configure(photoPoke: pokeData.pokemonPhoto, weightPoke: pokeData.pokemonWeight!, heightPoke: pokeData.pokemonHeight!, countTypePoke2: pokeData.pokemonCount1!, countTypePoke1: pokeData.pokemonCount2!, nameTypePoke2: pokeData.pokemonNamaType2!, nameTypePoke1: pokeData.pokemonNamaType1!, namePoke: pokeData.pokemonName!)
        }
        // Do any additional setup after loading the view.
    }
    
  
    private func configure(
        photoPoke: String,
        weightPoke: String,
        heightPoke: String,
        countTypePoke2: String,
        countTypePoke1: String,
        nameTypePoke2: String,
        nameTypePoke1: String,
        namePoke: String
        
    ) {
        self.countTypePoke1.text = countTypePoke1
        self.countTypePoke2.text = countTypePoke2
        self.heightPoke.text = heightPoke
        self.namePoke.text = namePoke
        self.nameTypePoke1.text = nameTypePoke1
        self.nameTypePoke2.text = nameTypePoke2
        let imgString = photoPoke
        let imgPoke = imgString.imageFromBase64
        self.photoPoke.image = imgPoke
        self.weightPoke.text = weightPoke
    }

    @IBAction func removeFavPokeMon(_ sender: UIButton) {
        guard let namePokemon = poke?.pokemonName else { return }
        let favoriteName = String(namePokemon)
        favoriteProvider.deleteFavorite(favoriteName) {
            DispatchQueue.main.async {
                self.favPokeBtn.setImage(UIImage(systemName: "suit.heart"), for: .normal)
                
                self.present(Alert.createAlertController(title: "Remove Succeeded", message: "Pokemon has been removed from favorites"), animated: true)
                self.favoriteProvider.getAllFavoritePokemon(completion: {pokemon in
                    DispatchQueue.main.async { [weak self] in
                        self?.navigationController?.popViewController(animated: true)
                    }
                })
            }
        }
    }
    
    @IBAction func editPokemonBtn(_ sender: UIButton) {
        guard let namePokemon = poke?.pokemonName else { return }
        guard let heightPokemon = poke?.pokemonHeight else { return }
        guard let weightPokemon = poke?.pokemonWeight else { return }
        guard let photoPokemon = poke?.pokemonPhoto else { return }
        guard let idPokemon = poke?.id else { return }
        
        let alert = UIAlertController(title: "Warning", message: "Do you want to change this Pokemon?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Yes", style: .default) { _ in
            let editVc = self.storyboard?.instantiateViewController(identifier: "UpdatePokemonViewController") as! UpdatePokemonViewController
            editVc.id = idPokemon
            editVc.pokemonHeigtEdit = heightPokemon
            editVc.pokemonNameEdit = namePokemon
            editVc.pokemonWeigtEdit = weightPokemon
            editVc.pokemonPhotoedit = photoPokemon
            self.navigationController?.pushViewController(editVc, animated: true)
        })

        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
    
}
