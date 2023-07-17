//
//  FavoriteDetailViewController.swift
//  Pokemon
//
//  Created by Indah Nurindo on 14/07/2566 BE.
//

import UIKit

class FavoriteDetailViewController: UIViewController {
    
    @IBOutlet weak var photoPoke: UIImageView!
    
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
            }
        }
    }
}
