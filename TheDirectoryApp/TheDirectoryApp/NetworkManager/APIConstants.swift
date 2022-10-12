//
//  APIConstants.swift
//  TheDirectoryApp
//
//  Created by Manju Kiran on 12/10/2022.
//

import Foundation

enum APIConstants {
    private static let baseURL = "https://61e947967bc0550017bc61bf.mockapi.io/api/v1/"
    
    enum EndPoint: String {
        case people
        case rooms
        
        var url: URL? {
            URL(string: APIConstants.baseURL + self.rawValue)
        }
    }
}


enum NetworkError: Error {
    case invalidURL
}
