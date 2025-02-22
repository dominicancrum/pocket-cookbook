//
//  PocketCookbookApp.swift
//  PocketCookbook
//
//  Created by Dominic Ancrum on 2/6/25.
//

import Recipes
import SwiftUI

@main
struct PocketCookbookApp: App {
    var body: some Scene {
        WindowGroup {
          RecipeList(viewModel: RecipeListViewModel())
        }
    }
}
