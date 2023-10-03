//
//  MHFactoryProtocol.swift
//  MyHeroes
//
//  Created by Doni on 25/07/23.
//

import Foundation

public protocol MHFactoryProtocol {
    func makeHeroesListViewController(heroName: String) -> HeroesListViewController
    func makeHeroDetailsViewController(hero: HeroEntity) -> HeroDetailsViewController
}
