//
//  HTTPMethod.swift
//  NetworkKit
//
//  Created by Dominic Ancrum on 2/20/25.
//

import Foundation

/// An enumeration representing the possible HTTP methods for a network request.
public enum HTTPMethod: Equatable {
  case get([URLQueryItem])
  case put(Data?)
  case post(Data?)
  case delete
  case head
  
  public var name: String {
    switch self {
    case .get: "GET"
    case .put: "PUT"
    case .post: "POST"
    case .delete: "DELETE"
    case .head: "HEAD"
    }
  }
}
