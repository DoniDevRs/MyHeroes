//
//  FavoritesViewProtocol.swift
//  MyHeroes
//
//  Created by Doni on 25/07/23.
//

import UIKit

public protocol FavoritesViewProtocol: AnyObject {
    var content: UIView { get }
    var delegate: FavoritesViewDelegate? { get set }
    
    func updateView(with viewState: FavoritesViewState)
}

public protocol FavoritesViewDelegate: AnyObject {
    func goToHeroesDetails(heroEntity: HeroEntity)
    func showRemoveError(with dialog: DialogEntity)
}

extension FavoritesViewProtocol where Self: UIView {
    public var content: UIView { return self }
}
