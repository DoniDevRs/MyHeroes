//
//  FavoritesProtocol.swift
//  MyHeroes
//
//  Created by Doni on 25/07/23.
//

import UIKit

public protocol FavoritesViewControllerProtocol: AnyObject {
    var contentView: FavoritesViewProtocol? { get }
    var viewModel: FavoritesViewModelProtocol? { get }
    
    func updateView(with viewState: FavoritesViewState)
    func presentMHDialogOnMainThread(_ dialogEntity: DialogEntity)
    
}

public protocol FavoritesViewModelProtocol: AnyObject {
    var viewController: FavoritesViewControllerProtocol? { get }
    var viewState: FavoritesViewState { get }
    
    func initState()
}

public protocol FavoritesViewControllerDelegate: AnyObject {
    func goToHeroesDetails(heroEntity: HeroEntity)
}
