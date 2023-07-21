//
//  ViewController.swift
//  Pokemon
//
//  Created by Indah Nurindo on 12/07/2566 BE.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    let pokemonModelView = PokemonViewModel()
    var searchActive: Bool = false
    private lazy var favoriteProvider: PokemonProvider = {  return PokemonProvider() }()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        pokemonModelView.pokemonFilter = pokemonModelView.apiReseult.results
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        self.navigationItem.title = "PokemonList"
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        pokemonModel.self
        pokemonModelView.loadPokemonData { [weak self] in
            self?.collectionView.reloadData()
            print(self?.pokemonModelView.pokemonCount)
        }
    }
}



extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchActive == true {
            return pokemonModelView.pokemonFilterCount
        } else {
            return pokemonModelView.pokemonCount
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        if searchActive == true {
            let result = pokemonModelView.pokemonFilter [indexPath.row]
            cell.configure(with: result)
        } else {
            let result = pokemonModelView.apiReseult.results[indexPath.row]
            cell.configure(with: result)
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
            detail.pokemonLink = pokemonModelView.pokemonFilter[indexPath.row].url
            detail.titlePokemon = pokemonModelView.pokemonFilter[indexPath.row].name
            detail.isInFavorites = favoriteProvider.checkDataExistence(detail.titlePokemon!)
        } else {
            detail.pokemonLink = pokemonModelView.apiReseult.results[indexPath.row].url
            detail.titlePokemon = pokemonModelView.apiReseult.results[indexPath.row].name
            detail.isInFavorites = favoriteProvider.checkDataExistence(detail.titlePokemon!)
        }
      
        self.present(detail, animated: true)
    }
    
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        pokemonModelView.pokemonFilter = []
        if searchText == "" {
            searchActive = false
            pokemonModelView.pokemonFilter = pokemonModelView.apiReseult.results.self
            
        } else {
            searchActive = true
            for poke in pokemonModelView.apiReseult.results
            {
                if poke.name.lowercased().contains(searchText.lowercased())
                {
                    pokemonModelView.pokemonFilter.append(poke)
//                    print(pokemonFilter)
                }
            }
        }
        collectionView.reloadData()
    }
}
