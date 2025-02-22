//
//  MockSources.swift
//  Recipes
//
//  Created by Dominic Ancrum on 2/21/25.
//

import Foundation
import Utilities

struct MockRecipeProvider: RecipeSource {
  enum Variant {
    case recipes
    case malformedData
  }
  
  enum RecipeFetchError: Error {
    case malformedData
  }

  let variant: Variant
  
  init(variant: Variant) {
    self.variant = variant
  }
  
  func fetchRecipes() async -> Result<[Recipe], any Error> {
    switch variant {
    case .recipes:
        .success(MockRecipes.recipes)
    case .malformedData:
        .failure(RecipeFetchError.malformedData)
    }
  }
}

struct MockImageProvider: ImageSource {
  func image(for url: URL) async throws -> Data {
    try Data(contentsOf: url)
  }
}

enum MockRecipes {
  static let recipes: [Recipe] = [
    Recipe(
      name: "Baked Macaroni and Cheese",
      cuisine: "Soul Food",
      largePhotoUrl: nil,
      smallPhotoUrl: Bundle.module.url(forResource: "baked-mac-and-cheese", withExtension: "jpg"),
      uuid: UUID(),
      sourceURL: nil,
      youtubeURL: nil
    ),
    Recipe(
      name: "Candied Yams",
      cuisine: "Soul Food",
      largePhotoUrl: nil,
      smallPhotoUrl: nil,
      uuid: UUID(),
      sourceURL: nil,
      youtubeURL: nil
    ),
    Recipe(
      name: "Banana Pancakes",
      cuisine: "American",
      largePhotoUrl: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/large.jpg")!,
      smallPhotoUrl: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/small.jpg")!,
      uuid: UUID(),
      sourceURL: URL(string: "https://www.bbcgoodfood.com/recipes/banana-pancakes")!,
      youtubeURL: URL(string: "https://www.youtube.com/watch?v=kSKtb2Sv-_U")!
    )
  ]
}


