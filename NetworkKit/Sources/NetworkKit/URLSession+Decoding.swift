//
//  URLSession+Decoding.swift
//  NetworkKit
//
//  Created by Dominic Ancrum on 2/20/25.
//

import Foundation

public extension URLSession {
  /// Fetches and decodes a value specified by the given `NetworkRequest`.
  /// - Parameters:
  ///   - request: The `NetworkRequest` for the value to fetch and decode.
  ///   - decoder: The `JSONDecoder` instance to use for decoding the request. Defaults to
  ///   a `JSONDecoder` with the default formatting settings and decoding strategies.
  /// - Returns: An instance of the decoded `Value`.
  func decode<Value: Decodable>(
    _ request: NetworkRequest<Value>,
    using decoder: JSONDecoder = .init()
  ) async throws -> Value {
    let (data, _) = try await self.data(for: request.urlRequest)
    return try decoder.decode(Value.self, from: data)
  }
}
