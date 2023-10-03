//
//  MHDialogViewController.swift
//  MyHeroes
//
//  Created by Doni on 25/07/23.
//

import UIKit

public struct DialogEntity {
    public let title: String?
    public let message: String?
    public let buttonTitle: String?
}

class MHDialogViewController: UIViewController {
    
    enum Constants {
        static let containerBorderWidth: CGFloat = 2
        static let messageNumberofLines = 4
        static let alphaViewBg: CGFloat = 0.75
        static let containerWidth: CGFloat = 280
        static let containerHeight: CGFloat = 220
        static let titleLabelHeight: CGFloat = 28
        static let actionButtonHeigth: CGFloat = 44
        static let errorTitle = "Something went wrong"
        static let errorMessage = "Unable to complete request"
        static let buttonOk = "Ok"
    }
    
    // MARK: - UI
    
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .black
        containerView.layer.cornerRadius = Metrics.small
        containerView.layer.borderWidth = Constants.containerBorderWidth
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    private lazy var titleLabel: MHTitleLabel = {
        let titleLabel = MHTitleLabel(textAlignment: .center, fontSize: Metrics.padding)
        titleLabel.text = dialogEntity?.title ?? Constants.errorTitle
        titleLabel.textColor = .white
        return titleLabel
    }()
    
    private lazy var messageLabel: MHBodyLabel = {
        let messageLabel = MHBodyLabel(textAlignment: .center)
        messageLabel.text = dialogEntity?.message ?? Constants.errorMessage
        messageLabel.textColor = .white
        messageLabel.numberOfLines = Constants.messageNumberofLines
        return messageLabel
    }()
    
    private lazy var actionButton: MHButton = {
        let actionButton = MHButton(backgroudnColor: .systemYellow,
                                    foregroundColor: .white,
                                    title: dialogEntity?.buttonTitle ?? Constants.buttonOk)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        return actionButton
    }()
    
    private var dialogEntity: DialogEntity?
    
    // MARK: INITIALIZERS
    
    public init(_ dialogEntity: DialogEntity?) {
        super.init(nibName: nil, bundle: nil)
        self.dialogEntity = dialogEntity
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(Constants.alphaViewBg)
        setup()
    }
    
    private func setup() {
        buildHierarchy()
        addConstraints()
    }
    
    private func buildHierarchy() {
        view.addSubview(containerView)
        view.addSubview(titleLabel)
        view.addSubview(actionButton)
        view.addSubview(messageLabel)
    }
    
    private func addConstraints() {
        containerView.centerYTo(view.centerYAnchor)
        containerView.centerXTo(view.centerXAnchor)
        containerView.width(Constants.containerWidth)
        containerView.height(Constants.containerHeight)
        
        titleLabel.topTo(containerView.topAnchor, constant: Metrics.padding)
        titleLabel.leadingTo(containerView.leadingAnchor, constant: Metrics.padding)
        titleLabel.trailingTo(containerView.trailingAnchor, constant: Metrics.padding)
        titleLabel.height(Constants.titleLabelHeight)
        
        messageLabel.topTo(titleLabel.bottomAnchor, constant: Metrics.tiny)
        messageLabel.leadingTo(containerView.leadingAnchor, constant: Metrics.padding)
        messageLabel.trailingTo(containerView.trailingAnchor, constant: Metrics.padding)
        messageLabel.bottomTo(actionButton.topAnchor, constant: Metrics.little)
        
        actionButton.bottomTo(containerView.bottomAnchor, constant: Metrics.padding)
        actionButton.leadingTo(containerView.leadingAnchor, constant: Metrics.padding)
        actionButton.trailingTo(containerView.trailingAnchor, constant: Metrics.padding)
        actionButton.height(Constants.actionButtonHeigth)
    }
    
    @objc private func dismissVC() {
        dismiss(animated: true)
    }
    
}
