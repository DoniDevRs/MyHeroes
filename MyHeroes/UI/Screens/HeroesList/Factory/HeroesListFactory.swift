//
//  HeroesListFactory.swift
//  MyHeroes
//
//  Created by Doni on 24/07/23.
//

import Foundation

public struct HeroesListFactory {
    
    private let response: GetHeroesUseCaseResponse
    
    public init(_ response: GetHeroesUseCaseResponse) {
        self.response = response
    }
    
    public func make() -> [HeroEntity] {
        let hero = response.data.results.map { HeroEntity(id: $0.id,
                                                          heroName: $0.name,
                                                          description: $0.description,
                                                          thumbnail: $0.thumbnail.url,
                                                          urls: $0.urls)
        }
        return hero
    }
}
