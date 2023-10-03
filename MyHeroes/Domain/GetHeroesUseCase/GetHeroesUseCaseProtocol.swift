//
//  GetHeroesUseCaseProtocol.swift
//  MyHeroes
//
//  Created by Doni on 24/07/23.
//

import Foundation

public protocol GetHeroesUseCaseProtocol: AnyObject {
    func execute(heroName: String, page: Int, completion: @escaping (Result<GetHeroesUseCaseResponse, MHError>) -> Void)
}
