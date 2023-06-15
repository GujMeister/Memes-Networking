//
//  MemesAPI.swift
//  Memes (Networking)
//
//  Created by Luka Gujejiani on 16.06.23.
//

import Foundation

func getMemes() async throws -> MemeResponse {
    let memesURL = "https://api.imgflip.com/get_memes"
    
    guard let url = URL(string: memesURL) else {
        throw APIError.invalidURL
    }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        throw APIError.noDataReceived
    }
    
    do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(MemeResponse.self, from: data)
    } catch {
        throw APIError.invalidData
    }
}


enum APIError: Error {
    case invalidURL
    case noDataReceived
    case invalidData
}

struct MemeResponse: Codable {
    let success: Bool
    let data: MemeData
}

struct MemeData: Codable {
    let memes: [Meme]
}

struct Meme: Codable {
    let id: String
    let name: String
    let url: String
    let width: Int
    let height: Int
    let boxCount: Int
}
