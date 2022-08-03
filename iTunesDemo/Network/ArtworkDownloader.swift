//
//  ArtworkDownloader.swift
//  iTunesDemo (iOS)
//
//  Created by Becca Wye on 03/08/2022.
//

import Foundation
import UIKit
import Combine

enum ArtworkDownloader {
  static func download(url: String) -> AnyPublisher<UIImage, iTunesError> {
    guard let url = URL(string: url) else {
      return Fail(error: iTunesError.invalidPhotoURL)
        .eraseToAnyPublisher()
    }

    return URLSession.shared.dataTaskPublisher(for: url)
      .tryMap { response -> Data in
        guard
          let httpURLResponse = response.response as? HTTPURLResponse,
          httpURLResponse.statusCode == 200
          else {
            throw iTunesError.statusCode
        }
        
        return response.data
      }
      .tryMap { data in
        guard let image = UIImage(data: data) else {
          throw iTunesError.imageError
        }
        return image
      }
      .mapError { iTunesError.map($0) }
      .eraseToAnyPublisher()
  }
}
