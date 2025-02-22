import Foundation
import Testing
@testable import Recipes
import Utilities

@MainActor
struct RecipeListViewModelTests {
  @Test func recipesAfterInitialListAppearance() async {
    // Given
    let viewModel = RecipeListViewModel(recipeProvider: MockRecipeProvider(variant: .recipes), imageLoader: MockImageProvider())
    
    // When
    await viewModel.listWillAppear()
    
    // Then
    #expect(viewModel.currentRecipes == .fetched(MockRecipes.recipes))
  }
  
  @Test func recipesAfterFetchingMalformedRecipes() async {
    // Given
    let viewModel = RecipeListViewModel(recipeProvider: MockRecipeProvider(variant: .malformedData), imageLoader: MockImageProvider())
    
    // When
    await viewModel.listWillAppear()
    
    // Then
    #expect(viewModel.currentRecipes == .failed(MockRecipeProvider.RecipeFetchError.malformedData))
  }
  
  @Test func imageDataReturnedForRecipe() async throws {
    // Given
    let viewModel = RecipeListViewModel(recipeProvider: MockRecipeProvider(variant: .recipes), imageLoader: MockImageProvider())
    guard let expectedRecipe = MockRecipes.recipes.first, let expectedRecipeURL = expectedRecipe.smallPhotoUrl else {
      Issue.record("Failed to load expected recipe for test")
      return
    }
    
    let expectedRecipeImageData = try Data(contentsOf: expectedRecipeURL)
    
    // When
    await viewModel.listWillAppear()
    guard case let .fetched(recipes) = viewModel.currentRecipes,
          let fetchedRecipe = recipes.first,
          let viewModelImageData = try await viewModel.loadImage(for: fetchedRecipe) else {
      Issue.record("Failed to load test recipe")
      return
    }
    
    // Then
    #expect(viewModelImageData == expectedRecipeImageData)
  }
}
