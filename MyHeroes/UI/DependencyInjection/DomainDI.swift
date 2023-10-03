//
//  DomainDI.swift
//  MyHeroes
//
//  Created by Doni on 25/07/23.
//

import Foundation

class DomainDI {
    let service: ServiceProtocol
    
    init(service: ServiceProtocol) {
        self.service = service
    }
}

extension DomainDI: DomainDIProtocol {
    func resolveGetHeroesUseCase() -> GetHeroesUseCaseProtocol {
        return GetHeroesUseCase(service: service)
    }
}
