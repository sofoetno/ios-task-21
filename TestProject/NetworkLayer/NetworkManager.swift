//
//  NetworkManager.swift
//  TestProject
//
//  Created by Nana Jimsheleishvili on 23.11.23.
//

import Foundation

final class NetworkManager {
    
    // MARK: - Fixed: shared property should be static.
    static let shared = NetworkManager()
    
    public init() {}
    
    func get<T: Decodable>(url: String, completion: @escaping ((Result<T, Error>) -> Void)) {
        
        // MARK: - Fixed: The URL argument was an empty string.
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error {
                DispatchQueue.main.async { completion(.failure(error)) }
            }
            
            guard let data else { return }
            
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch let error {
                completion(.failure(error))
            }
        }.resume() // MARK: - Fixed: there was no resume() method invokation.
    }
}


