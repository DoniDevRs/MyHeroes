//
//  MHBaseFlowController.swift
//  MyHeroes
//
//  Created by Doni on 25/07/23.
//

import Foundation
import UIKit

class MHBaseFlowController {
    
    private var flowNavigation: UINavigationController
    private let tabBarMenu: UITabBarController = UITabBarController()
    private var tabs: [UIViewController] = []
    private let factory: MHFactoryProtocol
    
    init(flowNavigation: UINavigationController,
         factory: MHFactoryProtocol) {
        self.flowNavigation = flowNavigation
        self.factory = factory
    }
    
    public func rootViewController() -> UINavigationController {
        let viewController = LaunchScreenViewController()
        viewController.delegate = self
        UINavigationBar.appearance().tintColor = .systemYellow
        flowNavigation.pushViewController(viewController, animated: true)
        return flowNavigation
    }
    
    private func makeTabBarViewControllers() -> UITabBarController {
        tabs = [
            makeHeroHomeViewController(),
            makeFavoritesViewController()
        ]
        
        tabBarMenu.setViewControllers(tabs, animated: true)
        UITabBar.appearance().tintColor = .systemYellow
        UITabBar.appearance().isTranslucent = false
        return tabBarMenu
    }
    
    private func makeHeroHomeViewController() -> UIViewController {
        let homeVC = HeroHomeViewController()
        homeVC.delegate = self
        homeVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return homeVC
    }
    
    private func makeFavoritesViewController() -> UIViewController {
        let viewModel = FavoritesViewModel()
        let favoritesVC = FavoritesListViewController(viewModel: viewModel)
        favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        viewModel.viewController = favoritesVC
        favoritesVC.delegate = self
        return UINavigationController(rootViewController: favoritesVC)
    }
}

extension MHBaseFlowController: HeroHomeViewControllerDelegate {
    func goToHeroesListViewController(heroName: String) {
        let viewController = factory.makeHeroesListViewController(heroName: heroName)
        viewController.delegate = self
        flowNavigation.pushViewController(viewController, animated: true)
    }
}

extension MHBaseFlowController: HeroesListViewControllerDelegate {
    func goToHeroDetailsVC(hero: HeroEntity) {
        let viewController = factory.makeHeroDetailsViewController(hero: hero)
        viewController.delegate = self
        flowNavigation.pushViewController(viewController, animated: true)
    }
}

extension MHBaseFlowController: FavoritesViewControllerDelegate {
    func goToHeroesDetails(heroEntity: HeroEntity) {
        let viewController = factory.makeHeroDetailsViewController(hero: heroEntity)
        viewController.delegate = self
        flowNavigation.pushViewController(viewController, animated: true)
    }
}

extension MHBaseFlowController: LaunchScreenViewControllerDelegate {
    func goToHeroesHome() {
        let viewController = makeTabBarViewControllers()
        viewController.modalTransitionStyle = .crossDissolve
        return flowNavigation.pushViewController(viewController, animated: false)
    }
}

extension MHBaseFlowController: HeroDetailsViewControllerDelegate { }
