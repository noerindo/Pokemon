//
//  FavoriteViewController.swift
//  Pokemon
//
//  Created by Indah Nurindo on 14/07/2566 BE.
//

import UIKit


class FavoriteViewController: UIViewController {
    var favoriteViewModel = PokemonFavoriteModelView()

    @IBOutlet weak var collectionViewPokemon: UICollectionView!
   

    override func viewDidLoad() {
        super.viewDidLoad()

        favoriteViewModel.reloadTableDelegate = self
        favoriteViewModel.loadPokemon()
        collectionViewPokemon.dataSource = self
        collectionViewPokemon.delegate = self
        collectionViewPokemon.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        self.navigationItem.title = "Favorite Pokemon"
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoriteViewModel.loadPokemon()
        print(favoriteViewModel.pokemonFavCount)
    }
}

extension FavoriteViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteViewModel.pokemonFavCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        favoriteViewModel.configureCell(cell, at: indexPath)
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
        guard let model = favoriteViewModel.getFavoritesModel(index: indexPath.row) else { return }
        detailFav.poke = model
//        detailFav.pokeImage = model.pokemonPhoto
        self.navigationController?.pushViewController(detailFav, animated: true)
    }
    
    
}

extension FavoriteViewController: PokemnViewModelDelegate {
    func pokemonFav() {
        DispatchQueue.main.async {
            self.collectionViewPokemon.reloadData()
        }
    }
}
