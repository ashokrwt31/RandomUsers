//
//  ARAPI.swift
//  RandomUsers
//
//  Created by Ashok Rawat on 21/05/23.
//

import Foundation

public enum HTTPMethod: String {
    case GET
    case POST
    
    var method: String { rawValue.uppercased() }
}

enum NetworkError: Error {
    case invalidUrl
    case invalidData
}

enum API {
    static let baseURL: String? = "https://randomuser.me/api/"
    static let placeHolderImageURL = "https://via.placeholder.com/200x200"
}
