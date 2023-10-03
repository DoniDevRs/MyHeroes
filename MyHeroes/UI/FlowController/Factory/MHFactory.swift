//
//  MHFactory.swift
//  MyHeroes
//
//  Created by Doni on 25/07/23.
//

import Foundation
import UIKit

class MHFactory: MHFactoryProtocol {
    
    let domainDI: DomainDIProtocol
    
    init(domainDI: DomainDIProtocol) {
        self.domainDI = domainDI
    }
    
    func makeHeroesListViewController(heroName: String) -> HeroesListViewController {
        let getHeroesUseCase = domainDI.resolveGetHeroesUseCase()
        let viewModel = HeroesListViewModel(getHeroesUseCase: getHeroesUseCase, heroName: heroName)
        let heroesListVC = HeroesListViewController(heroName: heroName, viewModel: viewModel)
        viewModel.viewController = heroesListVC
        return heroesListVC
    }
    
    func makeHeroDetailsViewController(hero: HeroEntity) -> HeroDetailsViewController {
        let viewModel = HeroDetailsViewModel(heroEntity: hero)
        let heroesDetailsVC = HeroDetailsViewController(heroEntity: hero, viewModel: viewModel)
        viewModel.viewController = heroesDetailsVC
        return heroesDetailsVC
    }
}
