//
//  FavoritesView.swift
//  MyHeroes
//
//  Created by Doni on 25/07/23.
//

import Foundation
import UIKit

final public class FavoritesView: UIView {
    
    enum Constants {
        static let rowHeight: CGFloat = 80.0
        static let emptyMessage = "No Favorites.\n Add one on the Heroes Details Screen"
    }
    
    // MARK: - UI
    
    private lazy var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var backgroundImage: UIImageView = {
        let backgroundImage = UIImageView()
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.image = Images.backgroundImage
        backgroundImage.contentMode = .scaleAspectFill
        return backgroundImage
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = Constants.rowHeight
        tableView.delegate = tableViewDataSource
        tableView.dataSource = tableViewDataSource
        tableView.backgroundColor = .clear
        tableView.separatorColor = .gray
        tableView.separatorInset = .init(top: .zero,
                                         left: Metrics.little,
                                         bottom: .zero,
                                         right: Metrics.little)
        tableView.removeExcessCells()
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.Constants.reuseID)
        return tableView
    }()
    
    private lazy var loadingView: MHLoadingView = {
        let loadingView = MHLoadingView()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        return loadingView
    }()
    
    private lazy var emptyView: MHEmptyStateView = {
        let emptyView = MHEmptyStateView(message: Constants.emptyMessage)
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        emptyView.isHidden = true
        return emptyView
    }()
    
    // MARK: - PUBLIC API
     
    public weak var delegate: FavoritesViewDelegate?
    private lazy var tableViewDataSource: FavoritesListViewDataSource = {
        return FavoritesListViewDataSource(favorites: [], delegate: self)
    }()
    
    // MARK: - INITIALIZERS
    
    override public init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PRIVATE
    
    private func setup() {
        buildViewHierachy()
        addConstraints()
    }
    
    private func buildViewHierachy() {
        addSubview(view)
        view.addSubview(backgroundImage)
        view.addSubview(tableView)
        view.addSubview(loadingView)
        view.addSubview(emptyView)
    }
    
    private func addConstraints() {
        view.constraintToSuperView()
        backgroundImage.constraintToSuperView()
        tableView.topTo(view.safeAreaLayoutGuide.topAnchor)
        tableView.leadingTo(view.leadingAnchor)
        tableView.trailingTo(view.trailingAnchor)
        tableView.bottomTo(view.safeAreaLayoutGuide.bottomAnchor)
        loadingView.constraintToSuperView()
        emptyView.constraintToSuperView()
    }
    
    private func updateViewLoading(show: Bool) {
        DispatchQueue.main.async {
            self.loadingView.isHidden = !show
        }
    }
    
    public func updateView(with favorites: [HeroEntity]) {
        if favorites.isEmpty {
            emptyView.isHidden = false
        } else {
            emptyView.isHidden = true
            tableViewDataSource.update(with: favorites)
            tableView.reloadDataOnMainThread()
        }
    }
}

extension FavoritesView: FavoritesListViewDataSourceDelegate {
    public func didSelectItem(with entity: HeroEntity) {
        delegate?.goToHeroesDetails(heroEntity: entity)
    }
    
    public func showRemoveError(with dialog: DialogEntity) {
        delegate?.showRemoveError(with: dialog)
    }
}

extension FavoritesView: FavoritesViewProtocol {
    public func updateView(with viewState: FavoritesViewState) {
        switch viewState {
        case let .hasData(data):
            updateView(with: data)
        case let .isLoading(show):
            updateViewLoading(show: show)
        case .isEmpty:
            break
        }
    }
}
