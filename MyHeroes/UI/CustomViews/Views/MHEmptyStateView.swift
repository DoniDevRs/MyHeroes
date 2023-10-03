//
//  MHEmptyStateView.swift
//  MyHeroes
//
//  Created by Doni on 25/07/23.
//

import UIKit

final public class MHEmptyStateView: UIView {
    
    enum Constants {
        static let numberOfLines = 3
        static let messageFontSize: CGFloat = 28
        static let messageHeight: CGFloat = 200
    }
    
    private lazy var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()
    
    private lazy var messageLabel: MHTitleLabel = {
        let label = MHTitleLabel(textAlignment: .center, fontSize: Constants.messageFontSize)
        label.numberOfLines = Constants.numberOfLines
        label.textColor = .systemYellow
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()

    private lazy var backgroundView: UIImageView = {
        let backgroundView = UIImageView()
        backgroundView.image = Images.backgroundImage
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.contentMode = .scaleAspectFill
        return backgroundView
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    private func setup() {
        buildViewHierarchy()
        addConstraints()
    }
    
    private func buildViewHierarchy() {
        addSubview(view)

        view.addSubview(backgroundView)
        view.addSubview(messageLabel)
    }
    
    private func addConstraints() {
        view.constraintToSuperView()
        
        messageLabel.centerYTo(view.centerYAnchor)
        messageLabel.leadingTo(view.leadingAnchor, constant: Metrics.big)
        messageLabel.trailingTo(view.trailingAnchor, constant: Metrics.big)
        messageLabel.height(Constants.messageHeight)
        
        backgroundView.constraintToSuperView()
    }
}
