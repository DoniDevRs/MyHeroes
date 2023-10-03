//
//  FavoritesViewState.swift
//  MyHeroes
//
//  Created by Doni on 25/07/23.
//

import Foundation

public enum FavoritesViewState {
    case hasData([HeroEntity])
    case isLoading(Bool)
    case isEmpty
}
