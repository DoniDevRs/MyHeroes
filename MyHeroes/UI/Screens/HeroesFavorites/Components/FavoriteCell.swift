//
//  FavoriteCell.swift
//  MyHeroes
//
//  Created by Doni on 25/07/23.
//

import UIKit

public class FavoriteCell: UITableViewCell {
    
    enum Constants {
        static let reuseID = "FavoriteCell"
        static let imageSize: CGFloat = 60.0
        static let labelHeight: CGFloat = 40.0
        static let usernameFontSize: CGFloat = 26.0
        static let imageBorderWidth: CGFloat = 2
        static let trailingUserNameLabel: CGFloat = 38
    }
    
    // MARK: - UI
    
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
    
    private lazy var usernameLabel: MHTitleLabel = {
        let label = MHTitleLabel(textAlignment: .left, fontSize: Constants.usernameFontSize)
        label.textColor = .systemYellow
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        buildViewHierarchy()
        addConstraints()
        backgroundColor = .clear
    }
    
    private func buildViewHierarchy() {
        addSubview(view)
        view.addSubview(heroImageView)
        view.addSubview(usernameLabel)
    }
    
    private func addConstraints() {
        view.constraintToSuperView()
        
        heroImageView.centerYTo(view.centerYAnchor)
        heroImageView.leadingTo(view.leadingAnchor, constant: Metrics.little)
        heroImageView.height(Constants.imageSize)
        heroImageView.width(Constants.imageSize)
        
        usernameLabel.centerYTo(view.centerYAnchor)
        usernameLabel.leadingTo(heroImageView.trailingAnchor, constant: Metrics.little)
        usernameLabel.trailingTo(view.trailingAnchor, constant: Constants.trailingUserNameLabel)
        usernameLabel.height(Constants.labelHeight)
        
    }
    
    public func updateView(with favorite: HeroEntity) {
        usernameLabel.text = favorite.heroName
        if let url = URL(string: favorite.thumbnail) {
            heroImageView.kf.setImage(with: url)
            heroImageView.kf.indicatorType = .activity
        } else {
            heroImageView.image = nil
        }
    }
}
