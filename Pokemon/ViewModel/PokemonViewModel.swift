//
//  PokemonViewModel.swift
//  Pokemon
//
//  Created by Indah Nurindo on 19/07/2566 BE.
//

import Foundation
import UIKit
import SDWebImage

class PokemonViewModel {
    
    var detailViewController: DetailViewController?
    
      var apiReseult = PokemonIndex(results: [Pokemonn]())
    var pokemonId: String = ""
    private lazy var favoriteProvider: PokemonProvider = {  return PokemonProvider() }()
    var pokemons = PokemonIndex(results: [])
    var pokemonFilter : [Pokemonn] = []
    var pokemonSelected = [PokemonDetail]()
    var searchActive: Bool = false
    var apiDetail: PokemonDetail?
    
    
    
    var collectionViewPokemon: (() -> Void)?
     
    var pokemonCount: Int {
        get {
            return apiReseult.results.count
        }
    }
    
    func loadPokemonData(completion: @escaping (() -> Void)) {
        NetworkService.sharedApi.fetchingAPIData { apiData in
            
            DispatchQueue.main.async {
                self.apiReseult = apiData
                self.pokemonFilter = self.apiReseult.results
            }
            
            completion()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        pokemonFilter = []
        if searchText == "" {
            searchActive = false
            pokemonFilter = apiReseult.results.self
            
        } else {
            searchActive = true
            for poke in apiReseult.results
            {
                if poke.name.lowercased().contains(searchText.lowercased())
                {
                    pokemonFilter.append(poke)
                    print(pokemonFilter)
                }
            }
        }
    }

    func getDetail(url: String) {
        
        
                NetworkService.sharedApi.fetchingAPIDataDetail(url: url, handler: { apiData in
            
            self.apiDetail = apiData
            
            DispatchQueue.main.async { [self] in
                guard let unwrappedvc = detailViewController else { return }
                
                unwrappedvc.namePokemon.text = apiData.name
                unwrappedvc.heightPokemon.text = "Height : \(apiData.height)"
                unwrappedvc.weightPokemon.text = "Weight : \(apiData.weight)"
                unwrappedvc.nameTypeText.text = apiData.types[0].type?.name2
                unwrappedvc.slotTypeText.text = "\(apiData.types[0].slot)"
                
                let typeArry = apiData.types.count
                if typeArry >= 2 {
                    unwrappedvc.nameTypeText2.text = apiData.types[1].type?.name2
                    unwrappedvc.slotTypeText2.text = "\(apiData.types[1].slot)"
                } else {
                    unwrappedvc.nameTypeText2.text = apiData.types[0].type?.name2
                    unwrappedvc.slotTypeText2.text = "\(apiData.types[0].slot)"
                }
                unwrappedvc.photoPokemon.sd_setImage(with: apiData.sprites!.front_default)
                print("\(apiData.sprites!.front_default)")
                
                
            
            }
        }
    )}
    

}

