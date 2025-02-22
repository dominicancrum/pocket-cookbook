//
//  NetworkRequest.swift
//  NetworkKit
//
//  Created by Dominic Ancrum on 2/17/25.
//

import Foundation

/// A type containing the data needed to perform a network request.
public struct NetworkRequest<Response> {
  let url: URL
  let method: HTTPMethod
  let headers: [String: String]
  
  public init(url: URL, method: HTTPMethod, headers: [String : String] = [:]) {
    self.url = url
    self.method = method
    self.headers = headers
  }
}

public extension NetworkRequest {
  var urlRequest: URLRequest {
    var request = URLRequest(url: url)
    
    switch method {
    case .post(let data), .put(let data):
      request.httpBody = data
    case let .get(queryItems):
      var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
      components?.queryItems = queryItems
      guard let url = components?.url else {
        preconditionFailure("Couldn't create valid URL from components")
      }
      
      request = URLRequest(url: url)
    default:
      break
    }
    
    request.allHTTPHeaderFields = headers
    request.httpMethod = method.name
    return request
  }
}
