//
//  APIService.swift
//  PetFinderApp
//
//  Created by YouTube on 9/23/22.
//

import Foundation


class APIService {
    
    static let shared = APIService()
    
    private init() {}
    
    func createAccessTokenRequest() throws -> URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = APIConstants.host
        components.path = "/v2/oauth2/token"
        
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        urlRequest.httpMethod = "POST"
        
        urlRequest.httpBody = try JSONSerialization.data(withJSONObject: APIConstants.bodyParams)
        
        return urlRequest
    }
    
    func getAccessToken() async throws -> Token {
        let urlRequest = try createAccessTokenRequest()

        let (data, httpResponse) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = httpResponse as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let results = try decoder.decode(Token.self, from: data)
        
        return results
    }
    
    func search(token: String) async throws -> [Animal] {
        guard let url = URL(string: "https://api.petfinder.com/v2/animals?type=dog&page=1") else {
            throw NetworkError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, httpResponse) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = httpResponse as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        let decoder = JSONDecoder()
        let results = try decoder.decode(Response.self, from: data)
        
        return results.animals
    }
}

struct Token: Codable {
    let tokenType: String
    let expiresIn: Int
    let accessToken: String
}

struct Response: Codable {
    let animals: [Animal]
}

struct Animal: Codable {
    let name: String
    let description: String
    let url: String
}
