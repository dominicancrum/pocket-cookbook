//
//  ImageSource.swift
//  Utilities
//
//  Created by Dominic Ancrum on 2/20/25.
//

import Foundation
import NetworkKit

/// A type that represents a source of image data.
public protocol ImageSource: Sendable {
  func image(for url: URL) async throws -> Data
}

public actor DefaultImageSource: ImageSource {
  public static let shared = DefaultImageSource()
  
  private var cache: NSCache<NSURL, NSData> = NSCache()
  
  private init() {}

  public func image(for url: URL) async throws -> Data {
    guard let cachedImageData = cache.object(forKey: url as NSURL) as? Data else {
      let imageData = try await loadRemoteImage(for: url)
      cache.setObject(imageData as NSData, forKey: url as NSURL)
      return imageData
    }
    
    return cachedImageData
  }
  
  private func loadRemoteImage(for url: URL) async throws -> Data {
    let imageDataRequest: NetworkRequest<Data> = .init(url: url, method: .get([]))
    let (imageData, _) = try await URLSession.shared.data(for: imageDataRequest.urlRequest)
    return imageData
  }
}
