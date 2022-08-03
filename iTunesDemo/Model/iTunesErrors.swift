//
//  iTunesErrors.swift
//  iTunesDemo (iOS)
//
//  Created by Becca Wye on 02/08/2022.
//

import Foundation

enum iTunesError: Error {
  case statusCode
  case decoding
  case invalidPhotoURL
  case imageError
  case other(Error)
  
  static func map(_ error: Error) -> iTunesError {
    return (error as? iTunesError) ?? .other(error)
  }
}
