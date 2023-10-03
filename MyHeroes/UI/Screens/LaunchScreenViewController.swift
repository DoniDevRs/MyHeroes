//
//  LaunchScreenViewController.swift
//  MyHeroes
//
//  Created by Doni on 28/07/23.
//

import UIKit

public protocol LaunchScreenViewControllerDelegate: AnyObject {
    func goToHeroesHome()
}

final public class LaunchScreenViewController: UIViewController {
    
    enum Constants {
        static let imageLogoSize: CGFloat = 250
    }
    
    public weak var delegate: LaunchScreenViewControllerDelegate?
    
    // MARK: - UI
    
    private lazy var backgroundView: UIImageView = {
        let backgroundView = UIImageView()
        backgroundView.image = Images.backgroundImage
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.contentMode = .scaleAspectFill
        return backgroundView
    }()
    
    private lazy var imageLogoView: UIImageView = {
        let imageLogoView = UIImageView()
        imageLogoView.image = Images.imageLogoView
        imageLogoView.translatesAutoresizingMaskIntoConstraints = false
        imageLogoView.contentMode = .scaleAspectFill
        imageLogoView.layer.cornerRadius = Metrics.little
        imageLogoView.clipsToBounds = true
        return imageLogoView
    }()
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        setup()
    }
    
    private func setup() {
        buildViewHierarchy()
        addConstraints()
        animateView()
    }
    
    private func animateView() {
        UIView.animate(withDuration: 1.0, delay: 1.8 ,animations: {
            self.backgroundView.alpha = 0
        }, completion: { done in
            if done {
                self.delegate?.goToHeroesHome()
            }
        })
    }
    
    private func buildViewHierarchy() {
        view.addSubview(backgroundView)
        backgroundView.addSubview(imageLogoView)
    }
    
    private func addConstraints() {
        backgroundView.constraintToSuperView()
        
        imageLogoView.centerYTo(backgroundView.centerYAnchor)
        imageLogoView.centerXTo(backgroundView.centerXAnchor)
        imageLogoView.height(Constants.imageLogoSize)
        imageLogoView.width(Constants.imageLogoSize)
    }
}
