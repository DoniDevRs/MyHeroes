//
//  HeroesListViewState.swift
//  MyHeroes
//
//  Created by Doni on 24/07/23.
//

import Foundation

public enum HeroesListViewState {
    case hasData([HeroEntity])
    case isLoading(Bool)
    case isEmpty
}
