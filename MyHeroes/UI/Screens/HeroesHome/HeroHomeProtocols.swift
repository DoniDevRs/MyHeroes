//
//  HeroHomeProtocols.swift
//  MyHeroes
//
//  Created by Doni on 24/07/23.
//

import Foundation

public protocol HeroHomeViewControllerProtocol: AnyObject {
    var contentView: HeroHomeViewProtocol? { get }
}

public protocol HeroHomeViewControllerDelegate: AnyObject {
    func goToHeroesListViewController(heroName: String)
}
