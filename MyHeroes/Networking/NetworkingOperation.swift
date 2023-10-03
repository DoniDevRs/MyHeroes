//
//  NetworkingOperation.swift
//  MyHeroes
//
//  Created by Doni on 24/07/23.
//

import Foundation

public class NetworkingOperation: NetworkingOperationProtocol {
    func execute<T>(_ request: RequestProtocol, response: T.Type, completion: @escaping (Result<T, MHError>) -> Void) where T : Decodable {
        guard let urlRequest = self.makeURLRequest(request) else {
            completion(.failure(.invalidURL))
            return
        }
        let session = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let serializedResponse = try decoder.decode(T.self, from: data)
                completion(.success(serializedResponse))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        session.resume()
    }
    
    private func makeURLRequest(_ request: RequestProtocol) -> URLRequest? {
        guard let url = URL(string: request.baseURL + request.path) else {
            return nil
        }
        return URLRequest(url: url)
    }
}
