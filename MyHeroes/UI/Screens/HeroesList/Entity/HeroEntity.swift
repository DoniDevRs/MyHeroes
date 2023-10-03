//
//  HeroEntity.swift
//  MyHeroes
//
//  Created by Doni on 24/07/23.
//

import Foundation

public struct HeroEntity: Codable, Hashable {
    public let id: Int
    public let heroName: String
    public let description: String?
    public let thumbnail: String
    public let urls: [HeroUrlData]?
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(heroName)
    }
    
    public static func == (lhs: HeroEntity, rhs: HeroEntity) -> Bool {
        lhs.heroName == rhs.heroName
    }
}
