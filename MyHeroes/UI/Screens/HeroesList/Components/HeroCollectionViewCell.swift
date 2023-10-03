//
//  HeroCollectionViewCell.swift
//  MyHeroes
//
//  Created by Doni on 24/07/23.
//

import UIKit
import Kingfisher

public class HeroCollectionViewCell: UICollectionViewCell {
    
    enum Constants {
        static let reuseID = "HeroCell"
        static let heroNameHeightFont = 50.0
        static let imageBorderWidth: CGFloat = 2
    }
    
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
        
    private lazy var heroNameLabel: UILabel = {
        let heroNameLabel = UILabel()
        heroNameLabel.translatesAutoresizingMaskIntoConstraints = false
        heroNameLabel.textAlignment = .center
        heroNameLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        heroNameLabel.textColor = .systemYellow
        heroNameLabel.adjustsFontSizeToFitWidth = true
        heroNameLabel.minimumScaleFactor = 0.9
        heroNameLabel.lineBreakMode = .byTruncatingTail
        heroNameLabel.numberOfLines = .zero
        return heroNameLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        buildViewHierarchy()
        addConstraints()
    }

    private func buildViewHierarchy() {
        addSubview(view)
        view.addSubview(heroImageView)
        view.addSubview(heroNameLabel)
    }

    private func addConstraints() {
        view.constraintToSuperView()

        heroImageView.topTo(topAnchor, constant: Metrics.tiny)
        heroImageView.leadingTo(leadingAnchor, constant: Metrics.tiny)
        heroImageView.trailingTo(trailingAnchor, constant: Metrics.tiny)
        heroImageView.height(heroImageView.widthAnchor)

        heroNameLabel.topTo(heroImageView.bottomAnchor, constant: Metrics.little)
        heroNameLabel.leadingTo(leadingAnchor, constant: Metrics.tiny)
        heroNameLabel.trailingTo(trailingAnchor, constant: Metrics.tiny)
        heroNameLabel.height(Constants.heroNameHeightFont)
    }
    
    public func updateView(with hero: HeroEntity) {
        heroNameLabel.text = hero.heroName
        if let url = URL(string: hero.thumbnail) {
            heroImageView.kf.setImage(with: url)
            heroImageView.kf.indicatorType = .activity
        } else {
            heroImageView.image = nil
        }
    }
}
