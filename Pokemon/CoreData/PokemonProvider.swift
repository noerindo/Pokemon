//
//  PokemonProvider.swift
//  Pokemon
//
//  Created by Indah Nurindo on 14/07/2566 BE.
//

import CoreData
import UIKit

class PokemonProvider {
    
//    let shared = PokemonProvider()
    
    lazy var persistentContainer: NSPersistentContainer = {
            let container = NSPersistentContainer(name: "PokemonData")
            
            container.loadPersistentStores { _, error in
                guard error == nil else {
                    fatalError("Unresolved error \(error!)")
                }
            }
            container.viewContext.automaticallyMergesChangesFromParent = false
            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            container.viewContext.shouldDeleteInaccessibleFaults = true
            container.viewContext.undoManager = nil
            
            return container
        }()
    
    private func newTaskContext() -> NSManagedObjectContext {
          let taskContext = persistentContainer.newBackgroundContext()
          taskContext.undoManager = nil
          
          taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
          return taskContext
      }
     func createPokemon(
        _ id: Int,
        _ pokemonCount1: String,
        _ pokemonCount2: String,
        _ pokemonHeight: String,
        _ pokemonNamaType1: String,
        _ pokemonNamaType2: String,
        _ pokemonName: String,
        _ pokemonPhoto: String,
        _ pokemonWeight: String,
        completion: @escaping() -> Void
     ) {
         let taskContext = newTaskContext()
         
         let pokemonData = PokemonData(context: taskContext)
         pokemonData.id = Int32(id)
         pokemonData.pokemonCount1 = pokemonCount1
         pokemonData.pokemonCount2 = pokemonCount2
         pokemonData.pokemonHeight = pokemonHeight
         pokemonData.pokemonNamaType1 = pokemonNamaType1
         pokemonData.pokemonNamaType2 = pokemonNamaType2
         pokemonData.pokemonName = pokemonName
         pokemonData.pokemonPhoto = pokemonPhoto
         pokemonData.pokemonWeight = pokemonWeight
         
         do {
             try taskContext.save()
             print("Saved")
             completion()
         } catch {
             print(error)
         }
         
    }
    
    func checkDataExistence(_ pokemonNama: String) -> Bool {
        var isExist = false
        let taskContext = newTaskContext()
        let predicate = NSPredicate(format: "pokemonName = %@", pokemonNama)
       
            let fetchRequst = NSFetchRequest<NSManagedObject>(entityName: "PokemonData")
        
            fetchRequst.predicate = predicate
            do {
                let result = try taskContext.fetch(fetchRequst)
                if result.count > 0 {
                    isExist = true
                }
                
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
                
            }
        return isExist
       
    }
    
//    func getPokemon(_ photoPokemon: String,  completion: @escaping(_ pokemons: FavoritePokemonModel) -> Void) {
//       let taskContext = newTaskContext()
//        taskContext.perform {
//            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName:"PokemonData")
//            do {
//                let result = try taskContext.fetch(fetchRequest)
//                let pokemon = FavoritePokemonModel(
//                    id: result.value(forKeyPath: "id") as? Int32,
//                    pokemonCount1: result.value(forKeyPath: "pokemonCount1") as? String,
//                    pokemonCount2: result.value(forKeyPath: "pokemonCount2") as? String,
//                    pokemonHeight: result.value(forKeyPath: "pokemonHeight") as? String,
//                    pokemonNamaType1: result.value(forKeyPath: "pokemonNamaType1") as? String,
//                    pokemonNamaType2: result.value(forKeyPath: "pokemonNamaType1") as? String,
//                    pokemonName: result.value(forKeyPath: "pokemonName") as? String,
//                    pokemonPhoto: (result.value(forKeyPath: "pokemonPhoto") as? String)!,
//                    pokemonWeight: result.value(forKeyPath: "pokemonWeight") as? String
//
//                )
//                completion(pokemon)
//
//
//            }
//        }
//    }
    
    func getAllFavoritePokemon(completion: @escaping(_ pokemon: [FavoritePokemonModel]) -> Void) {
      let taskContext = newTaskContext()
      taskContext.perform {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PokemonData")
        do {
          let results = try taskContext.fetch(fetchRequest)
          var pokemons: [FavoritePokemonModel] = []
          for result in results {
           let pokemon = FavoritePokemonModel(
            id: result.value(forKeyPath: "id") as? Int32,
            pokemonCount1: result.value(forKeyPath: "pokemonCount1") as? String,
            pokemonCount2: result.value(forKeyPath: "pokemonCount2") as? String,
            pokemonHeight: result.value(forKeyPath: "pokemonHeight") as? String,
            pokemonNamaType1: result.value(forKeyPath: "pokemonNamaType1") as? String,
            pokemonNamaType2: result.value(forKeyPath: "pokemonNamaType1") as? String,
            pokemonName: result.value(forKeyPath: "pokemonName") as? String,
            pokemonPhoto: (result.value(forKeyPath: "pokemonPhoto") as? String)!,
            pokemonWeight: result.value(forKeyPath: "pokemonWeight") as? String
           )

            pokemons.append(pokemon)
              print("fetchPokemon:",pokemons)
          }
          completion(pokemons)
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
      }
    }
     
    func deleteFavorite(_ pokemonNama: String, completion: @escaping() -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PokemonData")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "pokemonName = %@", pokemonNama)
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeCount
            if let batchDeleteResult =
                try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult,
                batchDeleteResult.result != nil {
                completion()
                print("hapus berhasil")
            }
        }
    }
    
    func updatePokemon(
                           _ pokemonHeight: String,
                           _ pokemonName: String,
                           _ pokemonWeight: String,
                           _ photoPokemon: String,
                           completion: @escaping() -> Void) {
    let taskContext = newTaskContext()
    taskContext.perform {
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PokemonData")
        fetchRequest.predicate = NSPredicate(format: "pokemonPhoto = %@", photoPokemon)
        if let results = try? taskContext.fetch(fetchRequest) {
            print("resultUpdate",results.count)
            do {
                
                for index in 0..<results.count {
                    let dataToUpdate = results[index]
                    dataToUpdate.setValue(pokemonName, forKeyPath: "pokemonName")
                    dataToUpdate.setValue(pokemonHeight, forKeyPath: "pokemonHeight")
                    dataToUpdate.setValue(pokemonWeight, forKeyPath: "pokemonWeight")
                }
                
                try taskContext.save()
                self.getAllFavoritePokemon(completion: { pokemon in
                    print("getPokemon",pokemon)
                })
                print("sukses")
               
                
            } catch {
                print("error update pokemon")
            }
        }
    }
}
    
    func updatePokemonNew(_ pokemonName: String, _ pokemonHeight: String, _ pokemonWeight: String) {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let context = appDelegate?.persistentContainer.viewContext else { return }
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "PokemonData")
        
        do {
            let results = try context.fetch(fetchRequest)
            
            for index in 0..<results.count {
                let dataToUpdate = results[index] as! NSManagedObject
                dataToUpdate.setValue(pokemonName, forKey: "pokemonName")
                dataToUpdate.setValue(pokemonHeight, forKeyPath: "pokemonHeight")
                dataToUpdate.setValue(pokemonWeight, forKeyPath: "pokemonWeight")
                
                try context.save()
            }
            
            self.getAllFavoritePokemon(completion: { pokemon in
                print("fetchDataPokemon=",pokemon)
            })
            
        } catch let error{
            print("Unable to update pokemon ", error)
        }
    }
    
}
