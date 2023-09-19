//
//  ApiHandler.swift
//  Movie Search
//
//  Created by Armen on 2023-07-22.
//

import Foundation

class ApiHandler: ObservableObject {
    static let shared = ApiHandler()
    
    let apiKey = "353d8d2b"
    
    
    private init() {}
    
    
    func getBySearch(withQuery search: String, page: Int, completion: @escaping (Result<SearchObject, ApiError>) -> Void ) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "www.omdbapi.com"
        urlComponents.queryItems = [
            URLQueryItem(name: "s", value: search),
            URLQueryItem(name: "apikey", value: apiKey),
            URLQueryItem(name: "page", value: String(page))
        ]
        
        guard let url = urlComponents.url else {
            completion(.failure(ApiError.FailedToGetURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(ApiError.failedToFetchData))
                return
            }
            
            let decoder = JSONDecoder()
            if let jsonPost = try? decoder.decode(SearchObject.self, from: data) {
                completion(.success(jsonPost))
            } else {
                print("Error decoding SearchObject:", error)
                if let dataString = String(data: data, encoding: .utf8) {
                    print("Received Data:", dataString)
                }
                completion(.failure(ApiError.failedToDecodeData))
            }
        }.resume()
    }
    
    func getByID(withQuery id: String, completion: @escaping (Result<DetailedMovie, ApiError>) -> Void ) {
        guard let url = URL(string: "https://www.omdbapi.com/?i=\(id)&apikey=\(apiKey)")
        else {
            completion(.failure(ApiError.FailedToGetURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(ApiError.failedToFetchData))
                return
            }
            
            let decoder = JSONDecoder()
            
            if let jsonPost = try? decoder.decode(DetailedMovie.self, from: data) {
                completion(.success(jsonPost))
            } else {
                print("Error decoding DetailedMovie:", error)
                if let dataString = String(data: data, encoding: .utf8) {
                    print("Received Data:", dataString)
                }
                completion(.failure(ApiError.failedToDecodeData))
            }
        }.resume()
    }
    
}

enum ApiError: String, Error {
    case FailedToGetURL = "Oops, something went wrong."
    case failedToDecodeData = "Couldn't find it."
    case failedToFetchData = "Bad Connection..."
}

