//
//  GetHeroesUseCaseResponse.swift
//  MyHeroes
//
//  Created by Doni on 24/07/23.
//

import Foundation

public struct GetHeroesUseCaseResponse: Codable {
    public let code: Int
    public let status: String
    public let data: HeroesUseCaseData
}

public struct HeroesUseCaseData: Codable {
    public let offset: Int
    public let limit: Int
    public let total: Int
    public let count: Int
    public let results: [HeroesUseCaseHero]
}

public struct HeroesUseCaseHero: Codable {
    public let id: Int
    public let name: String
    public let description: String?
    public let thumbnail: Thumbnail
    public let urls: [HeroUrlData]?
}

public struct Thumbnail: Codable {
    public let path: String
    public let ext: String
    
    public var url: String {
        return path + "." + ext
    }
    
    enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
    }
}

public struct HeroUrlData: Codable {
    public let type: String
    public let url: String
}
