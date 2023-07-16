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
    var isInFavorites = false
    var result: PokemonDetail?
    private lazy var pokemonProvider: PokemonProvider = { return PokemonProvider() }()
//    var pokemonSave: [FavoritePokemonModel] = []
    
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
    var pokemonId: Int = 0
    private var pokemonName: String?
    
//    private lazy var managerCoreData: ManagerCoreData = { return ManagerCoreData() }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setupFavoriteBtn()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        guard let pokemonLinkk = pokemonLink else { return }
        NetworkService.sharedApi.fetchingAPIDataDetail(url: pokemonLinkk) { [weak self] apiData in
            
            self?.apiDetail = apiData
            
            DispatchQueue.main.async {
                self?.namePokemon.text = apiData.name
                self?.heightPokemon.text = "Height : \(apiData.height)"
                self?.weightPokemon.text = "Weight : \(apiData.weight)"
                self?.nameTypeText.text = apiData.types[0].type?.name2
                self?.slotTypeText.text = "\(apiData.types[0].slot)"
                
                let typeArry = apiData.types.count
                if typeArry >= 2 {
                    self?.nameTypeText2.text = apiData.types[1].type?.name2
                    self?.slotTypeText2.text = "\(apiData.types[1].slot)"
                } else {
                    self?.nameTypeText2.text = apiData.types[0].type?.name2
                    self?.slotTypeText2.text = "\(apiData.types[0].slot)"
                }
                self?.photoPokemon.sd_setImage(with: apiData.sprites!.back_default)
                print("\(apiData.sprites!.back_default)")
                
                
            
            }
        }
        
        self.navigationItem.title = titlePokemon

       
    }
    

    @IBAction func addFavorite(_ sender: UIButton) {
        if isInFavorites {
            print("hapus")
            deleteFavorite(sender)
        } else {
            print("save")
            savePokemon(sender)
        }
    }
    func setupFavoriteBtn() {
        guard let cekNameokemon = namePokemon.text else { return }
        pokemonProvider.checkDataExistence(cekNameokemon) { [weak self] result in
            guard let unwrappedSelf = self else { return }
            switch result {
            case .success(let isExists):
                unwrappedSelf.isInFavorites = isExists
                let systemName = unwrappedSelf.isInFavorites ? "suit.heart.fill" : "heart"
                unwrappedSelf.favoriteBtn.setImage(UIImage(systemName: systemName), for: .normal)
                unwrappedSelf.favoriteBtn.isEnabled = true
            case .failure(let error):
                print(error)
            }
        }
            }
    

    private func savePokemon(_ sender: UIButton) {
        guard let slotType = slotTypeText.text else {
            return
        }
        guard let slotType2 = slotTypeText2.text else { return }
        guard let heightPoke = heightPokemon.text else { return }
        guard let nameTypePoke = nameTypeText.text else { return }
        guard let nameTypePoke2 = nameTypeText2.text else { return }
        guard let namePoke = namePokemon.text else { return }
        guard let photoPoke = photoPokemon.image?.base64 else { return }
        guard let weightPoke = weightPokemon.text else { return }
        
        
        pokemonProvider.createPokemon(pokemonId, "\(slotType)", "\(slotType2)", "\(heightPoke)", "\(nameTypePoke)", "\(nameTypePoke2)", "\(namePoke)", "\(photoPoke)", "\(weightPoke)") {
            DispatchQueue.main.async {
                print("\(namePoke)")
                self.isInFavorites.toggle()
                self.setButtonBackGround(
                    view: sender,
                    on: UIImage(systemName: "suit.heart.fill")!.withTintColor(.red, renderingMode: .alwaysOriginal),
                    off: UIImage(systemName: "suit.heart")!,
                    onOffStatus: self.isInFavorites
                )
                self.present(Alert.createAlertController(title: "Successful", message: "Save Pokemon"),animated: true)
            }
            
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
        pokemonProvider.deleteFavorite(pokemonNameGuard, completion: {
            DispatchQueue.main.async {
                self.isInFavorites.toggle()
                self.setButtonBackGround(
                    view: sender,
                    on: UIImage(systemName: "suit.heart.fill")!.withTintColor(.red, renderingMode: .alwaysOriginal),
                    off: UIImage(systemName: "suit.heart")!,
                    onOffStatus: self.isInFavorites
                )
                self.present(Alert.createAlertController(title: "Successful", message: "Deleted Pokemon from Core Data"),animated: true)
            }
        })
        
    }
}

