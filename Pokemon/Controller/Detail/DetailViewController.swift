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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let pokemonLinkk = pokemonLink else { return }
        NetworkService.sharedApi.fetchingAPIDataDetail(url: pokemonLinkk) { [weak self] apiData in
            
            self?.apiDetail = apiData
            
            DispatchQueue.main.async {
                self?.namePokemon.text = apiData.name
                self?.heightPokemon.text = "Height : \(apiData.height)"
                self?.weightPokemon.text = "Weight : \(apiData.weight)"
                self?.nameTypeText.text = apiData.types[0].type?.name2
                self?.slotTypeText.text = "\(apiData.types[0].slot)"
                
                var typeArry = apiData.types.count
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


}

