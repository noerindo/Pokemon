//
//  FavoriteDetailViewController.swift
//  Pokemon
//
//  Created by Indah Nurindo on 14/07/2566 BE.
//

import UIKit


class FavoriteDetailViewController: UIViewController {
    
    var poke = FavoritePokemonModel()
    var pokemonViewModel = PokemonFavoriteModelView()
    var pokeName: String = ""
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonViewModel.setButtonImageAction = {
            DispatchQueue.main.async { [weak self] in
                self?.favPokeBtn.setImage(UIImage(systemName: "suit.heart"), for: .normal)
                self?.present(Alert.createAlertController(title: "Remove Succeeded", message: "Pokemon has been removed from favorites"), animated: true)
            }
        }
        
        pokemonViewModel.loadDetailPokemon(self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print(poke.pokemonName)
        pokemonViewModel.loadDetailPokemon(self)
    }
    
    func configurePokeDetail(
        photoPoke: String,
        weightPoke: String,
        heightPoke: String,
        countTypePoke2: String,
        countTypePoke1: String,
        nameTypePoke2: String,
        nameTypePoke1: String,
        namePoke: String
        
    ) {
        //            print("configure: \(namePoke)")
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
        pokeName = namePoke
    }
    
    @IBAction func removeFavPokeMon(_ sender: UIButton) {
        pokemonViewModel.removePoke(self)
    }
    
    @IBAction func editPokemonBtn(_ sender: UIButton) {
        let alert = UIAlertController(title: "Warning", message: "Do you want to change this Pokemon?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default) { _ in
            let editVc = self.storyboard?.instantiateViewController(identifier: "UpdatePokemonViewController") as! UpdatePokemonViewController
            editVc.delegate = self
            editVc.pokeUpdate = self.poke
            self.navigationController?.pushViewController(editVc, animated: true)
        })
        
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension FavoriteDetailViewController: UpdatePokemonViewControllerDelegate {
    
    func setDetailModel(newModel: FavoritePokemonModel) {
        print("Set detail model sebelum: \(self.poke.pokemonName)")
        self.poke = newModel
        print("Set detail model sesudah: \(self.poke.pokemonName)")
    }
}
