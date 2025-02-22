//
//  Fetchable.swift
//  Utilities
//
//  Created by Dominic Ancrum on 2/20/25.
//

import Foundation

/// A type representing the possible states a value can exist in while being
/// retrieved from some source (e.g. in-memory, on-disk, over the network, etc.)
public enum Fetchable<Value> {
  /// The state where the value is currently being fetched.
  case fetching
  /// The state where the value has been retrieved.
  case fetched(Value)
  /// The state indicating a failure to fetch the value, along with an optional associated `Error`.
  case failed(Error?)
}

extension Fetchable: Sendable where Value: Sendable {}

extension Fetchable: Equatable where Value: Equatable {
  public static func == (lhs: Fetchable<Value>, rhs: Fetchable<Value>) -> Bool {
    switch (lhs, rhs) {
    case (.fetching, .fetching):
      return true
    case (.fetched(let lhsValue), .fetched(let rhsValue)):
      return lhsValue == rhsValue
    case (.failed(let lhsError), .failed(let rhsError)):
      return lhsError?.localizedDescription == rhsError?.localizedDescription
    default:
      return false
    }
  }
}
