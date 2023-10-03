//
//  HeroDetailsViewController.swift
//  MyHeroes
//
//  Created by Doni on 25/07/23.
//

import UIKit

public class HeroDetailsViewController: UIViewController {
    
    // MARK: - PROPERTIES
    
    public let contentView: HeroDetailsViewProtocol?
    public let viewModel: HeroDetailsViewModelProtocol?
    public let heroEntity: HeroEntity?
    
    // MARK: - PUBLIC API
    
    weak var delegate: HeroDetailsViewControllerDelegate?
    
    // MARK: - PUBLIC INITIALIZERS
    
    public init(heroEntity: HeroEntity, contentView: HeroDetailsViewProtocol = HeroDetailsView(), viewModel: HeroDetailsViewModelProtocol) {
        self.heroEntity = heroEntity
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
        setupRightNavItem()
        viewModel?.initState()
    }
        
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func setup() {
        if let contentView = contentView {
            self.view = contentView.content
        }
        contentView?.delegate = self
    }
    
    private func setupRightNavItem() {
        updateButtonFav(false)
    }
            
    @objc func favoriteButtonTapped() {
        viewModel?.favoriteButtonTapped()
        updateButtonFav(true)
    }
    
    private func updateButtonFav(_ isFavorited: Bool) {
        let bubbleButton = UIButton(type: .system)
        bubbleButton.setImage(Images.liked, for: .normal)
        bubbleButton.frame = CGRect(x: .zero,
                                    y: .zero,
                                    width: Metrics.padding,
                                    height: Metrics.padding)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: bubbleButton)
        bubbleButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        let image: UIImage = isFavorited ? Images.liked : Images.like
        bubbleButton.setImage(image, for: .normal)
    }
}

extension HeroDetailsViewController: HeroDetailsViewDelegate {
    public func didTapGetMoreDetails() {
        viewModel?.getGetMoreDetails()
    }
}

extension HeroDetailsViewController: HeroDetailsViewControllerProtocol {
    public func updateView(with viewState: HeroDetailsViewState) {
        contentView?.updateView(with: viewState)
    }
    
    public func showDialog(with dialog: DialogEntity) {
        presentMHDialogOnMainThread(dialog)
    }
}
