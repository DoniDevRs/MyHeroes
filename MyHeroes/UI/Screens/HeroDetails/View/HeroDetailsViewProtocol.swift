//
//  HeroDetailsViewProtocol.swift
//  MyHeroes
//
//  Created by Doni on 25/07/23.
//

import UIKit

public protocol HeroDetailsViewProtocol: AnyObject {
    var content: UIView { get }
    var delegate: HeroDetailsViewDelegate? { get set }
    
    func updateView(with viewState: HeroDetailsViewState)
}

public protocol HeroDetailsViewDelegate: AnyObject {
    func didTapGetMoreDetails()
}

extension HeroDetailsViewProtocol where Self: UIView {
    public var content: UIView { return self }
}
