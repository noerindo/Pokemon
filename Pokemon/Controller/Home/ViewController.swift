//
//  ViewController.swift
//  Pokemon
//
//  Created by Indah Nurindo on 12/07/2566 BE.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UISearchBarDelegate {

    let pokemonModelView = PokemonViewModel()
    var searchActive: Bool = false
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        self.navigationItem.title = "PokemonList"
        
//        pokemonModelView.collectionViewPokemon = { [weak self] in
////            self?.pokemonModelView.loadPokemonData()
//
//            self?.collectionView.reloadData()
//
//        }
//       pokemonModelView.loadPokemonData()
//        self.collectionView.reloadData()
        
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
        pokemonModelView.pokemonCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        let result = pokemonModelView.apiReseult.results[indexPath.row]
        cell.configure(with: result)
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
        detail.pokemonLink = pokemonModelView.apiReseult.results[indexPath.row].url
        self.present(detail, animated: true)
    }
    
}

