//
//  HeroDetailsHeaderView.swift
//  MyHeroes
//
//  Created by Doni on 25/07/23.
//

import UIKit

final public class HeroDetailsHeaderView: UIView {
    
    private enum Constants {
        static let heightWidth: CGFloat = 200.0
        static let noDescription = "No Description Available."
        static let imageBorderWidth: CGFloat = 2
    }
    
    // MARK: UI
    
    private lazy var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var heroImageView: UIImageView = {
        let heroImageView = UIImageView()
        heroImageView.translatesAutoresizingMaskIntoConstraints = false
        heroImageView.clipsToBounds = true
        heroImageView.layer.cornerRadius = Metrics.tiny
        heroImageView.layer.borderColor = UIColor.red.cgColor
        heroImageView.layer.borderWidth = Constants.imageBorderWidth
        return heroImageView
    }()
    
    private lazy var heronameLabel: MHTitleLabel = {
        let usernameLabel = MHTitleLabel(textAlignment: .left, fontSize: Metrics.large)
        usernameLabel.textColor = .systemYellow
        usernameLabel.numberOfLines = .zero
        return usernameLabel
    }()
    
    private lazy var bioLabel: MHBodyLabel = {
        let bioLabel = MHBodyLabel(textAlignment: .left)
        bioLabel.textColor = .systemYellow
        bioLabel.numberOfLines = .zero
        return bioLabel
    }()
    
    // MARK: - INITIALIZERS
    
    public override init(frame: CGRect) {
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
        view.addSubview(heroImageView)
        view.addSubview(heronameLabel)
        view.addSubview(bioLabel)
    }
    
    private func addConstraints() {
        view.constraintToSuperView()
        
        heroImageView.topTo(view.topAnchor, constant: Metrics.padding)
        heroImageView.leadingTo(view.leadingAnchor)
        heroImageView.width(Constants.heightWidth)
        heroImageView.height(Constants.heightWidth)
        
        heronameLabel.topTo(heroImageView.bottomAnchor, constant: Metrics.little)
        heronameLabel.leadingTo(heroImageView.leadingAnchor)
        heronameLabel.trailingTo(view.trailingAnchor)

        bioLabel.topTo(heronameLabel.bottomAnchor, constant: Metrics.tiny)
        bioLabel.leadingTo(heronameLabel.leadingAnchor)
        bioLabel.trailingTo(view.trailingAnchor)
        
    }
    
    public func updateView(with hero: HeroEntity) {
        DispatchQueue.main.async {
            if let url = URL(string: hero.thumbnail) {
                self.heroImageView.kf.setImage(with: url)
                self.heroImageView.kf.indicatorType = .activity
            } else {
                self.heroImageView.image = nil
            }
            
            self.heronameLabel.text = hero.heroName
            guard !hero.description!.isEmpty else {
                self.bioLabel.text = Constants.noDescription
                return
            }
            self.bioLabel.text = hero.description
        }
    }
}
