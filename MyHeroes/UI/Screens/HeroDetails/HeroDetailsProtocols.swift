//
//  HeroDetailsProtocols.swift
//  MyHeroes
//
//  Created by Doni on 25/07/23.
//

import UIKit

public protocol HeroDetailsViewControllerProtocol: AnyObject {
    var contentView: HeroDetailsViewProtocol? { get }
    var viewModel: HeroDetailsViewModelProtocol? { get }
    
    func updateView(with viewState: HeroDetailsViewState)
    func showDialog(with dialog: DialogEntity)
    func presentSafariVC(with url: URL)
    func presentMHDialogOnMainThread(_ dialogEntity: DialogEntity)
}

public protocol HeroDetailsViewModelProtocol: AnyObject {
    var viewController: HeroDetailsViewControllerProtocol? { get }
    var viewState: HeroDetailsViewState { get }
    
    func initState()
    func getGetMoreDetails()
    func favoriteButtonTapped()
}

public protocol HeroDetailsViewControllerDelegate: AnyObject { }
