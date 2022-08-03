//
//  iTunesAPI.swift
//  iTunesDemo (iOS)
//
//  Created by Becca Wye on 02/08/2022.
//

import Foundation
import Combine


class TunesAPI {
    func getSongs(artist: String) -> AnyPublisher<iTunesResponse, iTunesError> {
        let term = artist.replacingOccurrences(of: " ", with: "+")
        let url = URL(string: "https://itunes.apple.com/search?term=\(term)&entity=song")!
        print(url)
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        let session = URLSession(configuration: config)
        let urlRequest = URLRequest(url: url)
        
        return session.dataTaskPublisher(for: urlRequest)
            .tryMap { response in
                guard
                    let httpURLResponse = response.response as? HTTPURLResponse,
                    httpURLResponse.statusCode == 200
                else {
                    throw iTunesError.statusCode
                }
                print(response.data)
                return response.data
            }
            .decode(type: iTunesResponse.self, decoder: JSONDecoder())
            .mapError { iTunesError.map($0) }
            .eraseToAnyPublisher()
    }
}

