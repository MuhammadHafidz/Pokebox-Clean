//
//  PokemonRemoteDataSource.swift
//  PokeBox
//
//  Created by Enygma System on 27/04/22.
//

import Foundation
import Alamofire
import RxSwift

protocol PokemonRemoteDataSourceProtocol: AnyObject {
    func getPokemons(_ offset: Int) -> Observable<[PokemonResponse]>
}

final class PokemonRemoteDataSource: NSObject {
    static let shared: PokemonRemoteDataSource = PokemonRemoteDataSource()
}

extension PokemonRemoteDataSource: PokemonRemoteDataSourceProtocol {
    func getPokemons(_ offset: Int) -> Observable<[PokemonResponse]> {
        let parameters: [String: Any] = [
            "query": GqlQuerys.Queries.pokemons(offset: offset).query
        ]
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        return Observable<[PokemonResponse]>.create { observer in
            if let url = URL(string: EndPoints.Gets.graphQl.url) {
                AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
                    .validate()
                    .responseDecodable(of: PokemonDataResponse.self) { res in
                        switch res.result {
                        case .success(let val):
                            observer.onNext(val.data.pokemon)
                            observer.onCompleted()
                        case .failure:
                            observer.onError(URLError.invalidResponse)
                        }
                    }
            }
            return Disposables.create()
        }
    }
    
}
