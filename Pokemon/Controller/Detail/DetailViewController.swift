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

    @IBOutlet weak var namePokemon: UILabel!
    @IBOutlet weak var heightPokemon: UILabel!
    @IBOutlet weak var viewCard: UIView! {
        didSet {
            viewCard.roundCorners(corners: [.allCorners], radius: 20)
        }
    }
    @IBOutlet weak var photoPokemon: UIImageView!
    @IBOutlet weak var weightPokemon: UILabel!
    
    var pokemonLink: String?
    var titlePokemon: String?
    var apiDetail = [PokemonDetail]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let pokemonLinkk = pokemonLink else { return }
        NetworkService.sharedApi.fetchingAPIDataDetail(url: pokemonLinkk) { [weak self] apiData in
            
            self?.apiDetail.append(apiData)
            
            DispatchQueue.main.async {
                self?.namePokemon.text = apiData.name
                self?.heightPokemon.text = "Height : \(apiData.height)"
                self?.weightPokemon.text = "Weight : \(apiData.weight)"
                self?.photoPokemon.sd_setImage(with: apiData.sprites!.back_default)
                
                
            
            }
        }
        self.navigationItem.title = titlePokemon

       
    }


}
