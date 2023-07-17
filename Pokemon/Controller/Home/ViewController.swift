//
//  ViewController.swift
//  Pokemon
//
//  Created by Indah Nurindo on 12/07/2566 BE.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    var apiReseult = PokemonIndex(results: [Pokemonn]())
    @IBOutlet weak var collectionView: UICollectionView!
    var pokemonId: String = ""
    private lazy var favoriteProvider: PokemonProvider = {  return PokemonProvider() }()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemonFilter : [Pokemonn] = []
    var pokemonSelected: Pokemonn?
    var searchActive: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkService.sharedApi.fetchingAPIData {
            apiData in
            self.apiReseult = apiData
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        searchBar.delegate = self
        pokemonFilter = apiReseult.results
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        self.navigationItem.title = "PokemonList"
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchActive == true {
            return pokemonFilter.count
        } else {
            return apiReseult.results.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        let cellList = apiReseult.results[indexPath.row]
        if searchActive == true {
            let celFilter = pokemonFilter[indexPath.row]
            cell.namePokemon.text = celFilter.name
            NetworkService.sharedApi.getIdFromUrl(url: celFilter.url) { resultId in
                self.pokemonId = resultId!
            }
            let imgUrl = URL(string:"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/\(pokemonId).png")
            cell.photoPokemon.sd_setImage(with: imgUrl)
            
        } else {
            cell.namePokemon.text = cellList.name
            NetworkService.sharedApi.getIdFromUrl(url: cellList.url) { resultId in
                self.pokemonId = resultId!
            }
            let imgUrl = URL(string:"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemonId).png")
            cell.photoPokemon.sd_setImage(with: imgUrl)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numOfColim = CGFloat(2)
        let collectionViewLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let spacing = (collectionViewLayout.minimumInteritemSpacing * CGFloat(numOfColim - 1)) + collectionViewLayout.sectionInset.left + collectionViewLayout.sectionInset.right
        let width = (collectionView.frame.size.width / numOfColim) - spacing

        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       let detail = self.storyboard?.instantiateViewController(identifier: "DetailViewController") as! DetailViewController
        
        if searchActive == true {
            detail.pokemonLink = pokemonFilter[indexPath.row].url
            detail.titlePokemon = pokemonFilter[indexPath.row].name
        } else {
            detail.pokemonLink = apiReseult.results[indexPath.row].url
            detail.titlePokemon = apiReseult.results[indexPath.row].name
        }
        detail.isInFavorites = favoriteProvider.checkDataExistence(detail.titlePokemon!)
        self.navigationController?.pushViewController(detail, animated: true)
    }
}

extension ViewController: UISearchBarDelegate {
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
        collectionView.reloadData()
    }
}
