//
//  Images.swift
//  MyHeroes
//
//  Created by Doni on 25/07/23.
//

import UIKit

enum Images {
    static let backgroundImage = UIImage(named: "backgroundImage")
    static let imageLogoView = UIImage(named: "imageLogo")
    static let like = UIImage(systemName: "heart")!.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
    static let liked = UIImage(systemName: "heart.fill")!.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
}
