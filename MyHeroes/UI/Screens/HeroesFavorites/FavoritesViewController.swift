//
//  FavoritesViewController.swift
//  MyHeroes
//
//  Created by Doni on 25/07/23.
//

import UIKit

public class FavoritesListViewController: UIViewController {

    private enum Constants {
        static let title = "Favorites"
    }
    
    // MARK: PROPERTIES
    
    public let contentView: FavoritesViewProtocol?
    public let viewModel: FavoritesViewModelProtocol?
    
    // MARK: - PUBLIC API
    
    public weak var delegate: FavoritesViewControllerDelegate?
    
    // MARK: - INITIALIZERS
    
    public init(contentView: FavoritesViewProtocol = FavoritesView(), viewModel: FavoritesViewModelProtocol) {
        self.contentView = contentView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.initState()
        configureNavigationBar(largeTitleColor: .white,
                               backgoundColor: .clear,
                               tintColor: .clear,
                               title: Constants.title,
                               preferredLargeTitle: true)
    }
    
    private func setup() {
        if let contentView = contentView {
            self.view = contentView.content
        }
        contentView?.delegate = self
    }
    
}

extension FavoritesListViewController: FavoritesViewControllerProtocol {
    public func updateView(with viewState: FavoritesViewState) {
        contentView?.updateView(with: viewState)
    }
}

extension FavoritesListViewController: FavoritesViewDelegate {
    public func goToHeroesDetails(heroEntity: HeroEntity) {
        delegate?.goToHeroesDetails(heroEntity: heroEntity)
    }
    
    public func showRemoveError(with dialog: DialogEntity) {
        presentMHDialogOnMainThread(dialog)
    }
}
