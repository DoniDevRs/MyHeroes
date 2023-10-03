//
//  ViewController.swift
//  MyHeroes
//
//  Created by Doni on 21/07/23.
//

import UIKit

public class HeroHomeViewController: UIViewController {
    
    // MARK: - PROPERTIES
    
    public let contentView: HeroHomeViewProtocol?
    
    // MARK: - PUBLIC API
    
    public weak var delegate: HeroHomeViewControllerDelegate?
    
    // MARK: PUBLIC INITIALIZERS
    
    init(contentView: HeroHomeViewProtocol? = HeroHomeView()) {
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func setup() {
        if let contentView = contentView {
            self.view = contentView.content
        }
        contentView?.delegate = self
    }
}

extension HeroHomeViewController: HeroHomeViewDelegate {
    public func searchHero(heroName: String?) {
        guard let heroName = heroName else { return }
        delegate?.goToHeroesListViewController(heroName: heroName)
    }
}
