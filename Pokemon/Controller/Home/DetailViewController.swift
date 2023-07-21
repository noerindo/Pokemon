//
//  DetailViewController.swift
//  Pokemon
//
//  Created by Indah Nurindo on 12/07/2566 BE.
//

import UIKit
import Alamofire
import SDWebImage

class DetailViewController: UIViewController {
    
    private var pokemonViewModel = PokemonViewModel()

    @IBOutlet weak var viewbgdetail: UIView! {
        didSet {
            viewbgdetail.layer.cornerRadius = 30
            viewbgdetail.backgroundColor = UIColor.gray
        }
    }
    @IBOutlet weak var slotTypeText2: UILabel!
    @IBOutlet weak var namePokemon: UILabel! {
        didSet {
            namePokemon.textColor = UIColor.white
        }
    }
    
    @IBOutlet weak var favoriteBtn: UIButton!
    var isInFavorites: Bool? = false
    var result: PokemonDetail?
    private lazy var pokemonProvider: PokemonProvider = { return PokemonProvider() }()
    
    @IBOutlet weak var slotTypeText: UILabel!
    @IBOutlet weak var nameTypeText2: UILabel!
    @IBOutlet weak var nameTypeText: UILabel!
    @IBOutlet weak var heightPokemon: UILabel!
    @IBOutlet weak var viewCard: UIView! {
        didSet {
            viewCard.layer.cornerRadius = 30
            viewCard.backgroundColor = UIColor.yellow
        }
    }
    @IBOutlet weak var photoPokemon: UIImageView!
    @IBOutlet weak var weightPokemon: UILabel!
    
    var pokemonLink: String?
    var titlePokemon: String?
    var apiDetail: PokemonDetail?
    private var pokemonName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        self.navigationItem.title = titlePokemon
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let isDataExist = isInFavorites else { return }
        if isDataExist {
            favoriteBtn.setImage(UIImage(systemName: "suit.heart.fill")!.withTintColor(.red, renderingMode: .alwaysOriginal), for: .normal)
        }

        guard let pokemonLinkk = pokemonLink else { return }
        pokemonViewModel.detailViewController = self
        pokemonViewModel.getDetail(url: pokemonLinkk)
    }
    

    @IBAction func addFavorite(_ sender: UIButton) {
        if isInFavorites! {
            print("hapus")
            deleteFavorite(sender)
        } else {
            print("save")
            savePokemon(sender)
        }
    }
    
    private func savePokemon(_ sender: UIButton) {
        pokemonViewModel.savedetail()
            DispatchQueue.main.async {
                self.isInFavorites?.toggle()
                self.setButtonBackGround(
                    view: sender,
                    on: UIImage(systemName: "suit.heart.fill")!.withTintColor(.red, renderingMode: .alwaysOriginal),
                    off: UIImage(systemName: "suit.heart")!,
                    onOffStatus: self.isInFavorites!
                )
                self.present(Alert.createAlertController(title: "Successful", message: "Save Pokemon"),animated: true)
            }
    }
    
    private func setButtonBackGround(view: UIButton, on: UIImage, off: UIImage, onOffStatus: Bool ) {
        switch onOffStatus {
        case true:
            view.setImage(on, for: .normal)
        default:
            view.setImage(off, for: .normal)
        }    }

    private func deleteFavorite(_ sender: UIButton) {
        guard let pokemonNameGuard = namePokemon.text else {
            return
        }
        pokemonViewModel.deleteFav(namePokemon: pokemonNameGuard)
            DispatchQueue.main.async {
                self.isInFavorites?.toggle()
                self.setButtonBackGround(
                    view: sender,
                    on: UIImage(systemName: "suit.heart.fill")!.withTintColor(.red, renderingMode: .alwaysOriginal),
                    off: UIImage(systemName: "suit.heart")!,
                    onOffStatus: self.isInFavorites!
                )
                self.present(Alert.createAlertController(title: "Successful", message: "Deleted Pokemon from Core Data"),animated: true)
            }
        }
        
    }


