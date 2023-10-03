//
//  HeroesListViewProtocol.swift
//  MyHeroes
//
//  Created by Doni on 24/07/23.
//

import UIKit

public protocol HeroesListViewProtocol: AnyObject {
    var content: UIView { get }
    var delegate: HeroesListViewDelegate? { get set }
    
    func updateView(with viewState: HeroesListViewState)
}

public protocol HeroesListViewDelegate: AnyObject {
    func getMoreHeroes(page: Int)
    func goToHeroDetailsVC(hero: HeroEntity)
    func showEmptyHeroes(with message: String)
}

extension HeroesListViewProtocol where Self: UIView {
    public var content: UIView { return self}
}
