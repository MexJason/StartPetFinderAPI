//
//  NetworkError.swift
//  PetFinderApp
//
//  Created by YouTube on 9/23/22.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case generalError
}
