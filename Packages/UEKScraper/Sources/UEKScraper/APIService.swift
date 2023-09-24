//
//  APIService.swift
//  UEKScraper
//
//  Created by Sebastian Staszczyk on 23/09/2023.
//

import Foundation

struct APIService {
    func getWebContent(from urlString: String) async throws -> String {
        let url = try getURL(from: urlString)
        let data = try await URLSession.shared.data(from: url)
        return String(decoding: data.0, as: UTF8.self)
    }

    private func getURL(from urlString: String) throws -> URL {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        return url
    }
}

