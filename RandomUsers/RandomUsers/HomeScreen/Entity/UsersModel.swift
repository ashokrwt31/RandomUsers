//
//  ARUsers.swift
//  RandomUsers
//
//  Created by Ashok Rawat on 21/05/23.
//

import Foundation

struct Name: Codable {
    let title: String
    let first: String
    let last: String
}

struct Street: Codable {
    let number: Int?
    let name: String?
}

struct Coordinates: Codable {
    let latitude: String?
    let longitude: String?
}

struct Timezone: Codable {
    let offset: String?
    let description: String?
}

struct Location: Codable {
    let street: Street
    let city: String
    let state: String
    let country: String
    
    let coordinates: Coordinates
    let timezone: Timezone
    
    private enum CodingKeys: String, CodingKey {
        case street, city, state, country, coordinates, timezone, postcodeRaw = "postcode"
    }
    
    let postcode: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let stringValue = try? container.decode(String.self, forKey: .postcodeRaw) {
            self.postcode = stringValue
        } else if let intValue = try? container.decode(Int.self, forKey: .postcodeRaw) {
            self.postcode = String(intValue)
        } else {
            throw DecodingError.dataCorruptedError(forKey: .postcodeRaw, in: container, debugDescription: "Invalid postcode value")
        }
        
        // Initialize other properties if needed
        street = try container.decode(Street.self, forKey: .street)
        city = try container.decode(String.self, forKey: .city)
        state = try container.decode(String.self, forKey: .state)
        country = try container.decode(String.self, forKey: .country)
        coordinates = try container.decode(Coordinates.self, forKey: .coordinates)
        timezone = try container.decode(Timezone.self, forKey: .timezone)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(postcode, forKey: .postcodeRaw)
    }
}

struct Login: Codable {
    let uuid: String
    let username: String
    let password: String
    let salt: String
    let md5: String
    let sha1: String
    let sha256: String
}

struct Dob: Codable {
    let date: String
    let age: Int
}

struct Registered: Codable {
    let date: String
    let age: Int
}

struct ID: Codable {
    let name: String?
    let value: String?
}

struct Picture: Codable {
    let large: String
    let medium: String
    let thumbnail: String
}

struct Info: Codable {
    let seed: String
    let results: Int
    let page: Int
    let version: String
}

struct User: Codable {
    let gender: String
    let name: Name
    let location: Location
    let email: String
    let login: Login
    let dob: Dob
    let registered: Registered
    let phone: String
    let cell: String
    let id: ID
    let picture: Picture
    let nat: String
    
}
struct Results: Codable {
    let results: [User]
    let info: Info
}
