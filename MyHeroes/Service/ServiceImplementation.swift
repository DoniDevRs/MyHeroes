//
//  ServiceImplementation.swift
//  MyHeroes
//
//  Created by Doni on 24/07/23.
//

import Foundation

class ServiceImplementation {
    let operation: NetworkingOperationProtocol
    
    init(operation: NetworkingOperationProtocol) {
        self.operation = operation
    }
}

extension ServiceImplementation: ServiceProtocol {
    func getHeroes(heroName: String, page: Int, completion: @escaping (Result<GetHeroesUseCaseResponse, MHError>) -> Void) {
        let request = ServiceRequest.getHeroes(heroName: heroName, page: page)
        operation.execute(request, response: GetHeroesUseCaseResponse.self, completion: completion)
    }
}
