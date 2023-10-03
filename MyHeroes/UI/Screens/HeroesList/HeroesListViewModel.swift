//
//  HeroesListViewModel.swift
//  MyHeroes
//
//  Created by Doni on 24/07/23.
//

import Foundation

public class HeroesListViewModel: HeroesListViewModelProtocol {
    
    enum Constants {
        static let buttonAlertOk = "OK"
    }
    
    // MARK: - PROPERTIES
    
    public weak var viewController: HeroesListViewControllerProtocol?
    public var viewEntity: [HeroEntity]?
    public var viewState: HeroesListViewState = .isEmpty {
        didSet {
            viewController?.updateView(with: viewState)
        }
    }
    
    private let getHeroesUseCase: GetHeroesUseCaseProtocol
    private var viewData: GetHeroesUseCaseResponse?
    private var heroName: String?
    private var page = 0
    
    // MARK: - PUBLIC INITIALIZERS
    
    public init(getHeroesUseCase: GetHeroesUseCaseProtocol, heroName: String) {
        self.getHeroesUseCase = getHeroesUseCase
        self.heroName = heroName
    }
    
    public func initState() {
        guard let heroName = heroName else { return }
        getHeroes(heroName: heroName, page: page)
    }
    
    func getHeroes(heroName: String, page: Int) {
        viewState = .isLoading(true)
        getHeroesUseCase.execute(heroName: heroName, page: page) { result in
            switch result {
            case let .success(response):
                self.viewData = response
                self.showHeroesListScreen(self.viewData)
            case let .failure(error):
                self.showDialog(self.makeDialog(error.rawValue))
            }
            self.viewState = .isLoading(false)
        }
    }
    
    // MARK: - PRIVATE
    
    private func showHeroesListScreen(_ data: GetHeroesUseCaseResponse?) {
        guard let data = data else {
            return
        }
        let entity = HeroesListFactory(data).make()
        viewEntity = entity
        self.viewState = .hasData(entity)
    }
    
    public func refreshData(page: Int) {
        guard let heroName = heroName else { return }
        getHeroes(heroName: heroName, page: page)
    }
    
    // MARK: = UTILS
    
    private func showDialog(_ dialogEntity: DialogEntity?) {
        guard let dialog = dialogEntity else { return }
        viewController?.showDialog(with: dialog)
    }

    private func makeDialog(_ error: String) -> DialogEntity {
        DialogEntity(title: nil, message: error, buttonTitle: Constants.buttonAlertOk)
    }
}
