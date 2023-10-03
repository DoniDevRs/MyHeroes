//
//  ServiceProtocol.swift
//  MyHeroes
//
//  Created by Doni on 24/07/23.
//

import Foundation

protocol ServiceProtocol {
    func getHeroes(heroName: String, page: Int, completion: @escaping (Result<GetHeroesUseCaseResponse, MHError>) -> Void)
    
}
