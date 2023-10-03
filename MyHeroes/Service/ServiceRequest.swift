//
//  ServiceRequest.swift
//  MyHeroes
//
//  Created by Doni on 24/07/23.
//

import Foundation
import SwiftHash

private let privateKey = "72812d51892c73b216af97bfdc7ef257b0bc43f5"
private let publicKey = "e149dfc09c024feaffda2989bb3d9306"
private let limit = 50

enum ServiceRequest: RequestProtocol {
    
    case getHeroes(heroName: String?, page: Int)
    
    var baseURL: String {
        return "https://gateway.marvel.com/v1/public/characters?"
    }
    
    var path: String {
        switch self {
        case .getHeroes(let heroName, let page):
            let offset = page * limit
            let startsWith: String
            if let heroName = heroName, !heroName.isEmpty {
                startsWith = "nameStartsWith=\(heroName.replacingOccurrences(of: " ", with: ""))&"
            } else {
                startsWith = ""
            }
            let url = "offset=\(offset)&limit=\(limit)&" + startsWith + getCredentials()
            return url
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getHeroes:
            return .get
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getHeroes:
            return nil
        }
    }
    
    var body: Data? {
        switch self {
        case .getHeroes:
            return nil
        }
    }
    
    private func getCredentials() -> String {
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(ts+privateKey+publicKey).lowercased()
        return "ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
    }
}
