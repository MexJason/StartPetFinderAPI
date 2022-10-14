//
//  APIConstants.swift
//  PetFinderApp
//
//  Created by YouTube on 9/23/22.
//

import Foundation

class APIConstants {
    static let clientId = "kK4MSKCnl6f8CT0w7qPg9c9VfwfOFPfdQe8CUcPfxWLxMbvQXI"
    static let clientSecret = "D31cBJy3f7LMBCU8tgyNMqoNlmmG3JdD1Hhn4ZhA"
    static let host = "api.petfinder.com"
    static let grantType = "client_credentials"
    
    static let bodyParams = [
        "client_id": clientId,
        "client_secret": clientSecret,
        "grant_type": grantType
    ]
}
