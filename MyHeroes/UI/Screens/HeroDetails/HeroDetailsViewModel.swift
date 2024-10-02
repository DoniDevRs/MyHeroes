//
//  HeroDetailsViewModel.swift
//  MyHeroes
//
//  Created by Doni on 25/07/23.
//

import Foundation

public class HeroDetailsViewModel: HeroDetailsViewModelProtocol {
    
    enum Constants {
        static let buttonOk = "Ok"
        static let titleAlertSuccess = "Success!"
        static let messageAlertSuccess = "You have successfully favorited this hero 🎉."
        static let titleMessageFailure = "Failure"
        static let messageAlertFailure = "Something went wrong."
    }
    
    // MARK: - PROPERTIES
    
    public weak var viewController: HeroDetailsViewControllerProtocol?
    public var viewState: HeroDetailsViewState = .isEmpty {
        didSet {
            viewController?.updateView(with: viewState)
        }
    }
    
    private var heroEntity: HeroEntity?
    
    // MARK: - PUBLIC INITIALIZERS
    
    public init(heroEntity: HeroEntity) {
        self.heroEntity = heroEntity
    }
    
    public func initState() {
        guard let heroEntity = heroEntity else { return }
        showHeroesDetailsScreen(heroEntity)
    }
    
    private func showHeroesDetailsScreen(_ hero: HeroEntity) {
        guard let hero = heroEntity else {
            return
        }
        viewState = .hasData(hero)
    }
    
    public func getGetMoreDetails() {
        guard let htmlUrl = heroEntity?.urls?.last?.url,
              let url = URL(string: htmlUrl)
        else {
            let alert = DialogEntity(title: Constants.titleMessageFailure,
                                     message: Constants.messageAlertFailure,
                                     buttonTitle: Constants.buttonOk)
            viewController?.presentMHDialogOnMainThread(alert)
            return }
        viewController?.presentSafariVC(with: url)
    }
    
    public func favoriteButtonTapped() {
        guard let hero = heroEntity else {
            return
        }
        addHeroToFavorites(hero: hero)
    }
    
    private func addHeroToFavorites(hero: HeroEntity) {
        let hero = HeroEntity(id: hero.id,
                              heroName: hero.heroName,
                              description: hero.description,
                              thumbnail: hero.thumbnail,
                              urls: hero.urls)
        PersistenceManager.updateWith(favorite: hero, actionType: .add) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else {
                let alert = DialogEntity(title: Constants.titleAlertSuccess,
                                         message: Constants.messageAlertSuccess,
                                         buttonTitle: Constants.buttonOk)
                self.viewController?.presentMHDialogOnMainThread(alert)
                return
            }
            let alert = DialogEntity(title: Constants.titleMessageFailure,
                                     message: error.rawValue,
                                     buttonTitle: Constants.buttonOk)
            self.viewController?.presentMHDialogOnMainThread(alert)
        }
    }
}
