//
//  NetworkService.swift
//  Pokemon
//
//  Created by Indah Nurindo on 12/07/2566 BE.
//

import Foundation
import Alamofire

class NetworkService {
    static let sharedApi = NetworkService()
    private let url = "https://pokeapi.co/api/v2/pokemon"
    func fetchingAPIData( handler: @escaping(_ apiData:PokemonIndex) -> (Void)) {
        AF.request(url, method: .get, parameters:  nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { responce in
            switch responce.result {
            case.success(let data):
                do {
                    let jsonData = try JSONDecoder().decode(PokemonIndex.self, from: data!)
                  // clousure calling
                    handler(jsonData)
                } catch {
                    print(String(describing: error))
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }.resume()
         
    }
    
    func fetchingAPIDataDetail (url: String, handler: @escaping ( _ apiData:PokemonDetail) -> (Void)) {
        AF.request(url, method: .get, parameters:  nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { responce in
            switch responce.result {
            case.success(let data):
                do {
                    let jsonData = try JSONDecoder().decode(PokemonDetail.self, from: data!)
                  // clousure calling
                    handler(jsonData)
                } catch {
                    print(String(describing: error))
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }.resume()
         
    }
}
