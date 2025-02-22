//
//  RecipeListViewModel.swift
//  Recipes
//
//  Created by Dominic Ancrum on 2/17/25.
//

import NetworkKit
import SwiftUI
import Utilities

/// A type representing the data model for a list of recipes.
@MainActor @Observable public final class RecipeListViewModel {
  // MARK: - Instance Properties

  // MARK: Public Properties
  /// `Fetchable` representing the current state of the recipes to be presented.
  private(set) public var currentRecipes: Fetchable<[Recipe]> = .fetching

  // MARK: Private Properties

  private var recipeSource: any RecipeSource
  private let imageSource: any ImageSource
  
  // MARK: - Initialization
  
  public init(
    recipeSource: any RecipeSource = DefaultRecipeSource(),
    imageSource: any ImageSource = DefaultImageSource.shared
  ) {
    self.recipeSource = recipeSource
    self.imageSource = imageSource
  }
  
  // MARK: - Instance Methods
  
  /// Informs the view model the associate list will be displayed. This will trigger
  /// an attempt to load any available recipes.
  public func listWillAppear() async {
    let recipes = await recipeSource.fetchRecipes()
    let updatedState: Fetchable<[Recipe]> = switch recipes {
    case .success(let value):
      .fetched(value)
    case .failure(let error):
      .failed(error)
    }
    
    withAnimation {
      currentRecipes = updatedState
    }
  }
  
  /// Informs the view model a refresh of the associated recipe list has been requested.
  /// This will set the UI to its loading sttate and trigger an attempt to reload any available recipes.
  public func reloadRequested() async {
    withAnimation {
      currentRecipes = .fetching
    }
    await listWillAppear()
  }
  
  /// Loads optional image data for the given recipe.
  /// - Parameter recipe: The recipe to fetch image data for.
  /// - Returns: A `Data` instance containing the recipe image's data, or `nil` if the image data
  /// could not be loaded.
  public func loadImage(for recipe: Recipe) async throws -> Data? {
    guard let recipePhotoURL = recipe.smallPhotoUrl else {
      return nil
    }
    
    return try await imageSource.image(for: recipePhotoURL)
  }
  
#if DEBUG
  public func updateRemoteRecipeSource(to remoteSource: RemoteRecipeSource) {
    recipeSource = DefaultRecipeSource(remoteSource: remoteSource)
    Task {
      await reloadRequested()
    }
  }
#endif
}
