//
//  FavoritesViewModel.swift
//  MyHeroes
//
//  Created by Doni on 25/07/23.
//

import Foundation

public class FavoritesViewModel: FavoritesViewModelProtocol {
    
    enum Constants {
        static let errorTitle = "Something went wrong"
        static let errorButton = "Ok"
    }
    
    // MARK: - PROPERTIES
    
    public weak var viewController: FavoritesViewControllerProtocol?
    public var viewState: FavoritesViewState = .isEmpty {
        didSet {
            viewController?.updateView(with: viewState)
        }
    }
    
    // MARK: - PUBLIC INITIALIZERS
    
    public init() {}
    
    public func initState() {
        getFavorites()
    }
    
    private func getFavorites() {
        viewState = .isLoading(true)
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(favorites):
                self.viewState = .hasData(favorites)
            case .failure(let error):
                let alert = DialogEntity(title: Constants.errorTitle,
                                         message: error.rawValue,
                                         buttonTitle: Constants.errorButton)
                self.viewController?.presentMHDialogOnMainThread(alert)
            }
        }
        viewState = .isLoading(false)
    }
}
