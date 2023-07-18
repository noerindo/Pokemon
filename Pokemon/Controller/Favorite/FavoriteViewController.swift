//
//  FavoriteViewController.swift
//  Pokemon
//
//  Created by Indah Nurindo on 14/07/2566 BE.
//

import UIKit

class FavoriteViewController: UIViewController {

    @IBOutlet weak var collectionViewPokemon: UICollectionView!
    var favorites = [FavoritePokemonModel]()
//    var activityIndicator: UIActivityIndicatorView!
    private lazy var favoriteProvider: PokemonProvider = {
        return PokemonProvider() }()
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        loadFavorites()
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPokemon()
        favoriteProvider.getAllFavoritePokemon { pokemon in
            DispatchQueue.main.async {
                self.favorites = pokemon
                self.collectionViewPokemon.reloadData()
            }
        }
        collectionViewPokemon.dataSource = self
        collectionViewPokemon.delegate = self
        collectionViewPokemon.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        self.navigationItem.title = "Favorite Pokemon"
        // Do any additional setup after loading the view.
    }
    private func loadPokemon() {
        self.favoriteProvider.getAllFavoritePokemon { pokemon in
            DispatchQueue.main.async {
                self.favorites = pokemon
                self.collectionViewPokemon.reloadData()
            }
        }
    }

}

extension FavoriteViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        let cellList = favorites[indexPath.row]
        cell.namePokemon.text = cellList.pokemonName
        
        let imagePokemonString = cellList.pokemonPhoto;
        let images = imagePokemonString.imageFromBase64
        
        cell.photoPokemon.image = images
        loadPokemon()
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
        let detailFav = self.storyboard?.instantiateViewController(identifier: "FavoriteDetailViewController") as! FavoriteDetailViewController
        detailFav.poke = favorites[indexPath.row]
        self.navigationController?.pushViewController(detailFav, animated: true)
    }
    
    
}
