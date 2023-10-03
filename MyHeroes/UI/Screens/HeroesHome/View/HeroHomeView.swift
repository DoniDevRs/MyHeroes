//
//  HeroHomeView.swift
//  MyHeroes
//
//  Created by Doni on 24/07/23.
//

import UIKit

public protocol HeroHomeViewDelegate: AnyObject {
    func searchHero(heroName: String?)
}

final public class HeroHomeView: UIView, HeroHomeViewProtocol {
    
    public weak var delegate: HeroHomeViewDelegate?
    
    enum Constants {
        static let infoLabelText = "Enter the name of your favorite Marvel Hero to search for information:"
        static let textFieldPlaceholder = "Hero name"
        static let buttonTitle = "SEARCH"
        static let tfBorderWidth: CGFloat = 2
    }
    
    // MARK: - UI
    
    private lazy var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private lazy var squareView: UIView = {
        let squareView = UIView()
        squareView.translatesAutoresizingMaskIntoConstraints = false
        squareView.layer.cornerRadius = Metrics.tiny
        squareView.backgroundColor = .red
        return squareView
    }()
    
    private lazy var backgroundImage: UIImageView = {
        let backgroundImage = UIImageView()
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.image = Images.backgroundImage
        backgroundImage.contentMode = .scaleAspectFill
        return backgroundImage
    }()
        
    private lazy var infoLabel: UILabel = {
        let infoLabel = UILabel()
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.text = Constants.infoLabelText
        infoLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        infoLabel.numberOfLines = .zero
        infoLabel.textColor = .white
        infoLabel.textAlignment = .center
        return infoLabel
    }()
    
    private lazy var tfHeroName: UITextField = {
        let tfHeroName = UITextField()
        tfHeroName.translatesAutoresizingMaskIntoConstraints = false
        tfHeroName.attributedPlaceholder =
        NSAttributedString(string: Constants.textFieldPlaceholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        tfHeroName.textColor = .black
        tfHeroName.backgroundColor = .white
        tfHeroName.layer.cornerRadius = Metrics.tiny
        tfHeroName.layer.borderWidth = Constants.tfBorderWidth
        tfHeroName.layer.borderColor = UIColor.systemGray4.cgColor
        tfHeroName.adjustsFontSizeToFitWidth = true
        tfHeroName.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tfHeroName.frame.height))
        tfHeroName.leftViewMode = .always
        tfHeroName.autocorrectionType = .no
        tfHeroName.clearButtonMode = .whileEditing
        tfHeroName.returnKeyType = .go
        tfHeroName.delegate = self
        return tfHeroName
    }()
    
    public lazy var searchButton: MHButton = {
        let searchButton = MHButton(backgroudnColor: .systemYellow,
                                    foregroundColor: .white,
                                    title: Constants.buttonTitle)
        searchButton.addTarget(self, action: #selector(searchHero), for: .touchUpInside)
        return searchButton
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PRIVATE
    
    private func setup() {
        buildViewHierarchy()
        addConstraints()
    }
    
    private func buildViewHierarchy() {
        addSubview(view)
        view.addSubview(backgroundImage)
        view.addSubview(squareView)
        squareView.addSubview(infoLabel)
        squareView.addSubview(tfHeroName)
        squareView.addSubview(searchButton)
    }
    
    private func addConstraints() {
        view.constraintToSuperView()
        backgroundImage.constraintToSuperView()
        
        squareView.centerYTo(view.centerYAnchor)
        squareView.centerXTo(view.centerXAnchor)
        squareView.leadingTo(view.leadingAnchor, constant: 10)
        squareView.trailingTo(view.trailingAnchor, constant: 10)
        squareView.height(260)
                
        infoLabel.topTo(squareView.topAnchor, constant: 12)
        infoLabel.leadingTo(squareView.leadingAnchor, constant: 12)
        infoLabel.trailingTo(squareView.trailingAnchor, constant: 12)
        infoLabel.bottomTo(tfHeroName.topAnchor, constant: 16)
        
        tfHeroName.topTo(infoLabel.bottomAnchor, constant: 16)
        tfHeroName.leadingTo(squareView.leadingAnchor, constant: 12)
        tfHeroName.trailingTo(squareView.trailingAnchor, constant: 12)
        tfHeroName.height(50)
        
        searchButton.topTo(tfHeroName.bottomAnchor, constant: 22)
        searchButton.leadingTo(squareView.leadingAnchor, constant: 32)
        searchButton.trailingTo(squareView.trailingAnchor, constant: 32)
        searchButton.bottomTo(squareView.bottomAnchor, constant: 22)
        searchButton.height(50)
        
    }
    
    @objc func searchHero(){
        guard !tfHeroName.text!.isEmpty else {
            return
        }
        delegate?.searchHero(heroName: tfHeroName.text)
        tfHeroName.resignFirstResponder()
        tfHeroName.text = ""
    }
}

extension HeroHomeView: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchHero()
        return true
    }
}

