//
//  NetworkingOperationProtocol.swift
//  MyHeroes
//
//  Created by Doni on 24/07/23.
//

import Foundation

protocol NetworkingOperationProtocol: AnyObject {
    func execute<T: Codable>(_ request: RequestProtocol, response: T.Type, completion: @escaping (Result<T, MHError>) -> Void)
}
