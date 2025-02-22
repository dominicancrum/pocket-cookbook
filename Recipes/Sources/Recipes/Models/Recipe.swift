//
//  Recipe.swift
//  PocketCookbook
//
//  Created by Dominic Ancrum on 2/6/25.
//

import Foundation
import NetworkKit

public struct Recipe: Codable, Identifiable, Equatable, Sendable {
  let name: String
  let cuisine: String
  let largePhotoUrl: URL?
  let smallPhotoUrl: URL?
  let uuid: UUID
  let sourceURL: URL?
  let youtubeURL: URL?
  
  public var id: UUID { uuid }
  
  enum CodingKeys: String, CodingKey {
    case name
    case cuisine
    case largePhotoUrl = "photo_url_large"
    case smallPhotoUrl = "photo_url_small"
    case uuid
    case sourceURL = "source_url"
    case youtubeURL = "youtube_url"
  }
}
