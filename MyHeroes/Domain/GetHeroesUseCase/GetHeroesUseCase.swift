//
//  GetHeroesUseCase.swift
//  MyHeroes
//
//  Created by Doni on 24/07/23.
//

import Foundation

class GetHeroesUseCase {
    private let service: ServiceProtocol
    
    init(service: ServiceProtocol) {
        self.service = service
    }
}

extension GetHeroesUseCase: GetHeroesUseCaseProtocol {
    func execute(heroName: String, page: Int, completion: @escaping (Result<GetHeroesUseCaseResponse, MHError>) -> Void) {
        service.getHeroes(heroName: heroName, page: page, completion: completion)
    }
}
