//
//  RecipeSource.swift
//  Recipes
//
//  Created by Dominic Ancrum on 2/17/25.
//

import Foundation
import NetworkKit
import Utilities

/// A type that acts as a source for recipes.
public protocol RecipeSource: Sendable {
  /// Asynchronously fetches any available recipes.
  /// - Returns: A `Result` representing either the available recipes or an error indicating why the fetch failed.
  func fetchRecipes() async -> Result<[Recipe], any Error>
}

public struct DefaultRecipeSource: RecipeSource {
  public init() {}

  public func fetchRecipes() async -> Result<[Recipe], any Error> {
    guard let recipeRequest: NetworkRequest<RecipeResponse> = .fetchRecipes() else {
      return .failure(RecipeFetchError.requestCreationFailed)
    }
    
    let recipes: Result<[Recipe], any Error>
    do {
      let response = try await URLSession.shared.decode(recipeRequest)
      recipes = .success(response.recipes)
    } catch {
      recipes = .failure(error)
    }
    
    return recipes
  }
}

public extension DefaultRecipeSource {
  enum RecipeFetchError: Error {
    case requestCreationFailed
    
  }
}
