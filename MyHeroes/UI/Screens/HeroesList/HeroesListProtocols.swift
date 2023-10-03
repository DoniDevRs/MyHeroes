//
//  HeroesListProtocols.swift
//  MyHeroes
//
//  Created by Doni on 24/07/23.
//

import UIKit

public protocol HeroesListViewControllerProtocol: AnyObject {
    var contentView: HeroesListViewProtocol? { get }
    var viewModel: HeroesListViewModelProtocol? { get }
        
    func updateView(with viewState: HeroesListViewState)
    func showDialog(with dialog: DialogEntity)
    
}

public protocol HeroesListViewModelProtocol: AnyObject {
    var viewController: HeroesListViewControllerProtocol? { get }
    var viewEntity: [HeroEntity]? { get set }
    var viewState: HeroesListViewState { get }
    
    func initState()
    func refreshData(page: Int)
}

public protocol HeroesListViewControllerDelegate: AnyObject {
    func goToHeroDetailsVC(hero: HeroEntity)
}

