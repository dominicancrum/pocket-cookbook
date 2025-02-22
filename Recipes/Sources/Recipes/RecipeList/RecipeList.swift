//
//  RecipeList.swift
//  PocketCookbook
//
//  Created by Dominic Ancrum on 2/6/25.
//

import NetworkKit
import SwiftUI
import Utilities

// MARK: - Recipe List

public struct RecipeList: View {
  // MARK: - Instance Properties
  @State private var viewModel: RecipeListViewModel
  
  // MARK: - Intialization
  
  public init(viewModel: RecipeListViewModel) {
    self.viewModel = viewModel
  }
  
  // MARK: - View Layout
  
  public var body: some View {
    NavigationStack {
      Group {
        switch viewModel.currentRecipes {
        case .fetching:
          ProgressView()
        case .fetched(let recipes):
          viewForFetchedRecipes(recipes)
        case .failed:
          HStack {
            Image(systemName: "exclamationmark.triangle")
              .resizable()
              .frame(width: 20, height: 20)
            Text("There was a problem fetching the recipes")
          }
        }
      }
      .navigationBarTitle("Pocket Cookbook")
    }
    .task {
      try? await Task.sleep(for: .seconds(1))
      await viewModel.listWillAppear()
    }
  }
  
  @ViewBuilder private func viewForFetchedRecipes(_ recipes: [Recipe]) -> some View {
    if recipes.isEmpty {
      Text("No recipes available 😔")
    } else {
      List(recipes) { recipe in
        Cell(recipe: recipe, fetchRecipeImage: viewModel.loadImage(for:))
      }
      .refreshable {
        await viewModel.reloadRequested()
      }
    }
  }
}

// MARK: - Recipe List Cell

extension RecipeList {
  struct Cell: View {
    // MARK: - Instance Properties

    let recipe: Recipe
    let fetchRecipeImage: (Recipe) async throws -> Data?
    @State var recipePic: Fetchable<Image> = .fetching
    
    // MARK: - View Layout
    
    var body: some View {
      HStack {
        Rectangle()
          .fill(Color.gray)
          .frame(width: 50, height: 50)
          .overlay {
            recipeImageView
          }
        Text(recipe.name)
      }
      .task {
        recipePic = await getRecipeImage()
      }
    }
    
    @ViewBuilder private var recipeImageView: some View {
      switch recipePic {
      case .fetching:
        ProgressView()
      case .failed:
        Image(systemName: "exclamationmark.triangle").resizable()
      case .fetched(let image):
        image
      }
    }
    
    // MARK: - Instance Methods
    
    private func getRecipeImage() async -> Fetchable<Image> {
      do {
        let imageData = try await fetchRecipeImage(recipe)
        return if let imageData, let uiImage = UIImage(data: imageData) {
          .fetched(Image(uiImage: uiImage).resizable())
        } else {
          .failed(nil)
        }
      } catch {
        return .failed(error)
      }
    }
  }
}

//#Preview {
//  RecipeList()
//}
