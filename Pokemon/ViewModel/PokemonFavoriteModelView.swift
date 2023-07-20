//
//  PokemonFavoriteModelView.swift
//  Pokemon
//
//  Created by Indah Nurindo on 20/07/2566 BE.
//

import Foundation

protocol PokemnViewModelDelegate: AnyObject {
    func pokemonFav()
    
}
class PokemonFavoriteModelView {
    private var favorites = [FavoritePokemonModel]()
    private lazy var favoriteProvider: PokemonProvider = {
        return PokemonProvider() }()
    
    var pokemonFavCount: Int {
        get {
            return favorites.count
        }
    }
    
    var reloadTableDelegate: PokemnViewModelDelegate?
    
    var setButtonImageAction: (() -> Void)?
    
    func getFavoritesModel(index: Int) -> FavoritePokemonModel? {
        if index >= favorites.count {
            return nil
        }
        return favorites[index]
    }
    
     func loadPokemon() {
//        print("loadPokemon")
        self.favoriteProvider.getAllFavoritePokemon { pokemon in
//            print("pokemon==",pokemon)
            DispatchQueue.main.async {
                self.favorites = pokemon
                self.reloadTableDelegate?.pokemonFav() // Reload table
//                print("favoritesCount",self.favorites.count)
            }
        }
    }
    
    func configureCell(_ cell: CollectionViewCell, at indexPath: IndexPath) {
//        self.loadPokemon()
        let favoritePoke = favorites[indexPath.item]
        cell.configure(with: favoritePoke)
    }
    
    func loadDetailPokemon(_ detailView: FavoriteDetailViewController) {
        let model = detailView.poke
        print("Load detail pokemon: \(model.pokemonName)")
        DispatchQueue.main.async {
            detailView.configurePokeDetail(
                photoPoke: model.pokemonPhoto,
                weightPoke: model.pokemonWeight,
                heightPoke: model.pokemonHeight,
                countTypePoke2: model.pokemonCount2,
                countTypePoke1: model.pokemonCount1,
                nameTypePoke2: model.pokemonNamaType2,
                nameTypePoke1: model.pokemonNamaType1,
                namePoke: model.pokemonName)
        }
    }
    
    func removePoke(_ detailView: FavoriteDetailViewController) {
        let namePoke = detailView.pokeName
//        print("Yang mau dihapus: \(namePoke)")
        favoriteProvider.deleteFavorite(namePoke) { [weak self] in
            guard let setButtonImageAction = self?.setButtonImageAction else { return }
            setButtonImageAction()
        }
    }
    
    func editPoke(_ updateView: UpdatePokemonViewController, completion: @escaping ((FavoritePokemonModel) -> Void)) {
//        let model = updateView.pokeUpdate
        let height = updateView.editHeighPokemon.text
        let weight = updateView.editWeightPokemon.text
        let photo = updateView.pokemonPhotoedit
        let name = updateView.editNamePokemon.text
                
        favoriteProvider.updatePokemon(height ?? updateView.pokemonHeigtEdit, name ?? updateView.pokemonNameEdit, weight ?? updateView.pokemonWeigtEdit, photo) { updateModel in
            var newModel = updateView.pokeUpdate
            newModel.pokemonName = updateModel?.value(forKey: "pokemonName") as! String
            newModel.pokemonWeight = updateModel?.value(forKey: "pokemonWeight") as! String
            newModel.pokemonHeight = updateModel?.value(forKey: "pokemonHeight") as! String
            print("Sudah diupdate jadi: \(newModel.pokemonName)")
            
            completion(newModel)
        }
    }
    
    
    
    
}
