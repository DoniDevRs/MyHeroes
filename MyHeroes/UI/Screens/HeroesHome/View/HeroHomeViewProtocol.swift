//
//  HeroHomeViewProtocol.swift
//  MyHeroes
//
//  Created by Doni on 24/07/23.
//

import UIKit

public protocol HeroHomeViewProtocol: AnyObject {
    var content: UIView { get }
    var delegate: HeroHomeViewDelegate? { get set }
}

extension HeroHomeViewProtocol where Self: UIView {
    public var content: UIView { return self }
}
