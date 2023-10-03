//
//  HeroesListViewController.swift
//  MyHeroes
//
//  Created by Doni on 24/07/23.
//

import UIKit

public class HeroesListViewController: UIViewController {

    // MARK: - PROPERTIES
    
    public let contentView: HeroesListViewProtocol?
    public let viewModel: HeroesListViewModelProtocol?
    private var heroName: String?
    
    // MARK: - PUBLIC API
    
    public weak var delegate: HeroesListViewControllerDelegate?
    
    // MARK: - PUBLIC INITIALIZERS
    
    public init(heroName: String, contentView: HeroesListViewProtocol = HeroesListView(), viewModel: HeroesListViewModelProtocol) {
        self.heroName = heroName
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
        viewModel?.initState()
        title = heroName
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setup() {
        if let contentView = contentView {
            self.view = contentView.content
        }
        contentView?.delegate = self
    }
}

extension HeroesListViewController: HeroesListViewDelegate {
    public func goToHeroDetailsVC(hero: HeroEntity) {
        delegate?.goToHeroDetailsVC(hero: hero)
    }
    
    public func getMoreHeroes(page: Int) {
        viewModel?.refreshData(page: page)
    }
    
    public func showEmptyHeroes(with message: String) {
        showEmptyStateView(with: message)
    }
}

extension HeroesListViewController: HeroesListViewControllerProtocol {
    public func updateView(with viewState: HeroesListViewState) {
        contentView?.updateView(with: viewState)
    }
    
    public func showDialog(with dialog: DialogEntity) {
        presentMHDialogOnMainThread(dialog)
    }
}
