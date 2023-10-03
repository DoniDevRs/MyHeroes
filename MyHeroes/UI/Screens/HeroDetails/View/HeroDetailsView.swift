//
//  HeroDetailsView.swift
//  MyHeroes
//
//  Created by Doni on 25/07/23.
//

import UIKit

final public class HeroDetailsView: UIView {
    
    private enum Constants {
        static let buttonHeight: CGFloat = 50
        static let seeMoreDetailsText = "Get more details like Comics, Series, Stories..."
        static let buttonTitle = "Go to Marvel Page"
    }
    
    // MARK: UI
    
    private lazy var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var backgroundImage: UIImageView = {
        let backgroundImage = UIImageView()
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.image = Images.backgroundImage
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.alpha = 0.6
        return backgroundImage
    }()
    
    private lazy var headerView: HeroDetailsHeaderView = {
        let headerView = HeroDetailsHeaderView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()
    
    private lazy var getMoreDetailsLabel: MHBodyLabel = {
        let getMoreDetailsLabel = MHBodyLabel(textAlignment: .center)
        getMoreDetailsLabel.translatesAutoresizingMaskIntoConstraints = false
        getMoreDetailsLabel.text = Constants.seeMoreDetailsText
        getMoreDetailsLabel.textColor = .white
        getMoreDetailsLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return getMoreDetailsLabel
    }()
    
    public lazy var actionButton: MHButton = {
        let actionButton = MHButton(backgroudnColor: .systemYellow,
                                    foregroundColor: .white,
                                    title: Constants.buttonTitle)
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return actionButton
    }()
        
    // MARK: - PUBLIC API
    
    public weak var delegate: HeroDetailsViewDelegate?
    
    // MARK: - INITIALIZERS
    
    override public init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: PRIVATE
    
    private func setup() {
        buildViewHierarchy()
        addConstraints()
    }
    
    private func buildViewHierarchy() {
        addSubview(view)
        view.addSubview(backgroundImage)
        view.addSubview(headerView)
        view.addSubview(getMoreDetailsLabel)
        view.addSubview(actionButton)
        
    }
    
    private func addConstraints() {
        view.constraintToSuperView()
        backgroundImage.constraintToSuperView()
        
        headerView.topTo(view.safeAreaLayoutGuide.topAnchor)
        headerView.leadingTo(view.leadingAnchor, constant: Metrics.padding)
        headerView.trailingTo(view.trailingAnchor, constant: Metrics.padding)
        
        getMoreDetailsLabel.leadingTo(view.leadingAnchor, constant: Metrics.padding)
        getMoreDetailsLabel.trailingTo(view.trailingAnchor, constant: Metrics.padding)
        getMoreDetailsLabel.bottomTo(actionButton.topAnchor, constant: Metrics.small)
        
        actionButton.leadingTo(view.leadingAnchor, constant: Metrics.padding)
        actionButton.trailingTo(view.trailingAnchor, constant: Metrics.padding)
        actionButton.bottomTo(view.bottomAnchor, constant: Metrics.huge)
        actionButton.height(Constants.buttonHeight)
    }
    
    @objc func actionButtonTapped() {
        delegate?.didTapGetMoreDetails()
    }
    
    private func updateView(with hero: HeroEntity) {
        headerView.updateView(with: hero)
    }
}

extension HeroDetailsView: HeroDetailsViewProtocol {
    public func updateView(with viewState: HeroDetailsViewState) {
        switch viewState {
        case let .hasData(data):
            updateView(with: data)
        case .isEmpty:
            break
        }
    }
}
