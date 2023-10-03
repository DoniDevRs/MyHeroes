//
//  DomainDIProtocol.swift
//  MyHeroes
//
//  Created by Doni on 25/07/23.
//

import Foundation

protocol DomainDIProtocol {
    func resolveGetHeroesUseCase() -> GetHeroesUseCaseProtocol
}
