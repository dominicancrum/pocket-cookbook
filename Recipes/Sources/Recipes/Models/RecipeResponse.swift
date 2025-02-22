//
//  RecipeResponse.swift
//  Recipes
//
//  Created by Dominic Ancrum on 2/21/25.
//

import Foundation
import NetworkKit

struct RecipeResponse: Decodable, Sendable {
  let recipes: [Recipe]
}

extension NetworkRequest where Response == RecipeResponse {
  static func fetchRecipes() -> Self? {
    guard let recipeURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json") else {
      return nil
    }
    
    return NetworkRequest(url: recipeURL, method: .get([]))
  }
  
  static func fetchEmptyRecipes() -> Self? {
    guard let emptyRecipesURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json") else {
      return nil
    }
    
    return NetworkRequest(url: emptyRecipesURL, method: .get([]))
  }
  
  static func fetchMalformedRecipes() -> Self? {
    guard let malformedRecipesURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json") else {
      return nil
    }
    
    return NetworkRequest(url: malformedRecipesURL, method: .get([]))
  }
}
